interface axi4_if #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter ID_WIDTH = 4,
    parameter LEN_WIDTH = 8,
    parameter STRB_WIDTH = DATA_WIDTH/8
) (
    input logic aclk,
    input logic aresetn
);

  // Сигналы канала записи адреса (AW - Address Write)
  logic [ID_WIDTH-1:0] awid;      // Идентификатор транзакции записи
  logic [ADDR_WIDTH-1:0] awaddr;  // Адрес записи
  logic [LEN_WIDTH-1:0] awlen;    // Длина пакета (число передач - 1)
  logic [2:0] awsize;             // Размер передачи (в байтах: 1, 2, 4, 8, ...)
  logic [1:0] awburst;            // Тип пакета (FIXED, INCR, WRAP)
  logic  awlock;             // Тип блокировки (Normal, Exclusive)
  logic [3:0] awcache;            // Атрибуты кэша
  logic [2:0] awprot;             // Защита доступа
  logic awvalid;                  // Валидность адреса записи
  logic awready;                  // Готовность Slave принять адрес

  // Сигналы канала записи данных (W - Write Data)
  logic [DATA_WIDTH-1:0] wdata;   // Данные для записи
  logic [(DATA_WIDTH/8)-1:0] wstrb; // Строб для байтов
  logic wlast;                    // Индикатор последней передачи в пакете
  logic wvalid;                   // Валидность данных
  logic wready;                   // Готовность Slave принять данные

  // Сигналы канала ответа на запись (B - Write Response)
  logic [ID_WIDTH-1:0] bid;       // Идентификатор ответа
  logic [1:0] bresp;              // Ответ на запись (OKAY, EXOKAY, SLVERR, DECERR)
  logic bvalid;                   // Валидность ответа
  logic bready;                   // Готовность Master принять ответ

  // Сигналы канала чтения адреса (AR - Address Read)
  logic [ID_WIDTH-1:0] arid;      // Идентификатор транзакции чтения
  logic [ADDR_WIDTH-1:0] araddr;  // Адрес чтения
  logic [LEN_WIDTH-1:0] arlen;    // Длина пакета (число передач - 1)
  logic [2:0] arsize;             // Размер передачи
  logic [1:0] arburst;            // Тип пакета (FIXED, INCR, WRAP)
  logic  arlock;             // Тип блокировки
  logic [3:0] arcache;            // Атрибуты кэша
  logic [2:0] arprot;             // Защита доступа
  logic arvalid;                  // Валидность адреса чтения
  logic arready;                  // Готовность Slave принять адрес

  // Сигналы канала чтения данных (R - Read Data)
  logic [ID_WIDTH-1:0] rid;       // Идентификатор данных чтения
  logic [DATA_WIDTH-1:0] rdata;   // Данные чтения
  logic [1:0] rresp;              // Ответ на чтение (OKAY, EXOKAY, SLVERR, DECERR)
  logic rlast;                    // Индикатор последней передачи в пакете
  logic rvalid;                   // Валидность данных чтения
  logic rready;                   // Готовность Master принять данные

  // Modport для Master (управляет транзакциями)
  modport master_mp (
    input aclk,
    input aresetn,
    output awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awvalid,
    input awready,
    output wdata, wstrb, wlast, wvalid,
    input wready,
    input bid, bresp, bvalid,
    output bready,
    output arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arvalid,
    input arready,
    input rid, rdata, rresp, rlast, rvalid,
    output rready
  );

  // Modport для Slave (реагирует на транзакции)
  modport slave_mp (
    input aclk, aresetn,
    input awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awvalid,
    output awready,
    input wdata, wstrb, wlast, wvalid,
    output wready,
    output bid, bresp, bvalid,
    input bready,
    input arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arvalid,
    output arready,
    output rid, rdata, rresp, rlast, rvalid,
    input rready
  );

endinterface