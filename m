Return-Path: <linux-acpi+bounces-4962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF0C8A31FB
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D59D1C2241A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802D14A4C4;
	Fri, 12 Apr 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="rOsSTH/g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6514900B;
	Fri, 12 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934808; cv=none; b=gKdbKzyBNnJK2X3OLlHqdYjrEhxIpjlNiKj8AfU4PFSCoMpMzyRpumMCtjM5m3s5qyx3g415DR0SK9wq55itkYp+uj4C9zPG2r5h2C4UWBt3/TiIK8MPEAaTyPGZwGNE56A19rqQTGp2nfkXerpC5hJ2hKyfqMppJQCR+hlSuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934808; c=relaxed/simple;
	bh=BrB4fd0EIfoJm32v1/pLiLp2iA1q51MQmBMGalwsx0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ddhw6EfSrchm4bmocdZEBwzR8xOqDQSJU4L6xM1HTu7sr6FMw/28JTzVgBX7gDAfq+0dfrp4UNBqbPtidPi6SvljBL5ZqgpNljyL15gBQML/fEWSrc4TF8lfcdwTLZiPMejVX0UmtA3e4YE0elTO6MI3+KZ/LQg2xAfr31m+8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=rOsSTH/g; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 325afda96223d645; Fri, 12 Apr 2024 17:13:17 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 55BD566CC48;
	Fri, 12 Apr 2024 17:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712934797;
	bh=BrB4fd0EIfoJm32v1/pLiLp2iA1q51MQmBMGalwsx0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rOsSTH/gdY+b1i+DMJx17SI1r/BQSXKm+lKBiuUyEjD+iCjdW4wYmEeEbAlByzomB
	 A69PMHEmfihjwt6lkkFBgRg7UI2hp16xWHbbPaj/PtL9LZNiF0rrc/BmVXmaHzL5a4
	 Jnt1oWpOucRJ4EOe/xEyVUD/ZapB58uJ0Q88ly+cD5H2yBv3BQUH7n6L9ysrIRqf6X
	 Vsx1Qu0TENGUezU6jIq3L39Jvegli6kgLTm+rbEQdk6SbqXpzWrTbEXe4j5lxRDydT
	 HIPqb6448ggfFoCeorTKGJIUUEoBx0qlhHRMnKLIHNzNMsWnXecWZ6pEzF4FL7KFj7
	 LOFIpowOyuv4Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 07/12] ACPICA: Modify ACPI_OBJECT_COMMON_HEADER
Date: Fri, 12 Apr 2024 17:08:50 +0200
Message-ID: <22258754.EfDdHjke4D@kreacher>
In-Reply-To: <4920972.31r3eYUQgx@kreacher>
References: <4920972.31r3eYUQgx@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgv
 sehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: lijun <lijun01@kylinos.cn>

ACPICA commit 9788e0dc955b8d439c05ee369e43865e6f106caa

modify 4 macros:
ACPI_OBJECT_COMMON_HEADER,
ACPI_COMMON_BUFFER_INFO,
ACPI_COMMON_NOTIFY_INFO,
ACPI_COMMON_FIELD_INFO
they  cause  poor readability.so del the last ";"
and when use them in a single line with the ";"in the end.

Link: https://github.com/acpica/acpica/commit/9788e0dc
Signed-off-by: lijun <lijun01@kylinos.cn>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acobject.h | 107 ++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 1bdfeee5d7c5..8fc02946d3cd 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -48,7 +48,7 @@
 	u8                              descriptor_type;    /* To differentiate various internal objs */\
 	u8                              type;               /* acpi_object_type */\
 	u16                             reference_count;    /* For object deletion management */\
-	u8                              flags;
+	u8                              flags
 	/*
 	 * Note: There are 3 bytes available here before the
 	 * next natural alignment boundary (for both 32/64 cases)
@@ -71,10 +71,12 @@
  *****************************************************************************/
 
 struct acpi_object_common {
-ACPI_OBJECT_COMMON_HEADER};
+	ACPI_OBJECT_COMMON_HEADER;
+};
 
 struct acpi_object_integer {
-	ACPI_OBJECT_COMMON_HEADER u8 fill[3];	/* Prevent warning on some compilers */
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 fill[3];		/* Prevent warning on some compilers */
 	u64 value;
 };
 
@@ -86,23 +88,26 @@ struct acpi_object_integer {
  */
 #define ACPI_COMMON_BUFFER_INFO(_type) \
 	_type                           *pointer; \
-	u32                             length;
+	u32                             length
 
 /* Null terminated, ASCII characters only */
 
 struct acpi_object_string {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(char)	/* String in AML stream or allocated string */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_BUFFER_INFO(char);	/* String in AML stream or allocated string */
 };
 
 struct acpi_object_buffer {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(u8)	/* Buffer in AML stream or allocated buffer */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_BUFFER_INFO(u8);	/* Buffer in AML stream or allocated buffer */
 	u32 aml_length;
 	u8 *aml_start;
 	struct acpi_namespace_node *node;	/* Link back to parent node */
 };
 
 struct acpi_object_package {
-	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;	/* Link back to parent node */
+	ACPI_OBJECT_COMMON_HEADER;
+	struct acpi_namespace_node *node;	/* Link back to parent node */
 	union acpi_operand_object **elements;	/* Array of pointers to acpi_objects */
 	u8 *aml_start;
 	u32 aml_length;
@@ -116,11 +121,13 @@ struct acpi_object_package {
  *****************************************************************************/
 
 struct acpi_object_event {
-	ACPI_OBJECT_COMMON_HEADER acpi_semaphore os_semaphore;	/* Actual OS synchronization object */
+	ACPI_OBJECT_COMMON_HEADER;
+	acpi_semaphore os_semaphore;	/* Actual OS synchronization object */
 };
 
 struct acpi_object_mutex {
-	ACPI_OBJECT_COMMON_HEADER u8 sync_level;	/* 0-15, specified in Mutex() call */
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 sync_level;		/* 0-15, specified in Mutex() call */
 	u16 acquisition_depth;	/* Allow multiple Acquires, same thread */
 	acpi_mutex os_mutex;	/* Actual OS synchronization object */
 	acpi_thread_id thread_id;	/* Current owner of the mutex */
@@ -132,7 +139,8 @@ struct acpi_object_mutex {
 };
 
 struct acpi_object_region {
-	ACPI_OBJECT_COMMON_HEADER u8 space_id;
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 space_id;
 	struct acpi_namespace_node *node;	/* Containing namespace node */
 	union acpi_operand_object *handler;	/* Handler for region access */
 	union acpi_operand_object *next;
@@ -142,7 +150,8 @@ struct acpi_object_region {
 };
 
 struct acpi_object_method {
-	ACPI_OBJECT_COMMON_HEADER u8 info_flags;
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 info_flags;
 	u8 param_count;
 	u8 sync_level;
 	union acpi_operand_object *mutex;
@@ -178,33 +187,43 @@ struct acpi_object_method {
  */
 #define ACPI_COMMON_NOTIFY_INFO \
 	union acpi_operand_object       *notify_list[2];    /* Handlers for system/device notifies */\
-	union acpi_operand_object       *handler;	/* Handler for Address space */
+	union acpi_operand_object       *handler	/* Handler for Address space */
 
 /* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
 
 struct acpi_object_notify_common {
-ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+};
 
 struct acpi_object_device {
-	ACPI_OBJECT_COMMON_HEADER
-	    ACPI_COMMON_NOTIFY_INFO struct acpi_gpe_block_info *gpe_block;
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+	struct acpi_gpe_block_info *gpe_block;
 };
 
 struct acpi_object_power_resource {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO u32 system_level;
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+	u32 system_level;
 	u32 resource_order;
 };
 
 struct acpi_object_processor {
-	ACPI_OBJECT_COMMON_HEADER
-	    /* The next two fields take advantage of the 3-byte space before NOTIFY_INFO */
+	ACPI_OBJECT_COMMON_HEADER;
+
+	/* The next two fields take advantage of the 3-byte space before NOTIFY_INFO */
+
 	u8 proc_id;
 	u8 length;
-	ACPI_COMMON_NOTIFY_INFO acpi_io_address address;
+	ACPI_COMMON_NOTIFY_INFO;
+	acpi_io_address address;
 };
 
 struct acpi_object_thermal_zone {
-ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_NOTIFY_INFO;
+};
 
 /******************************************************************************
  *
@@ -226,17 +245,21 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 	u32                             base_byte_offset;   /* Byte offset within containing object */\
 	u32                             value;              /* Value to store into the Bank or Index register */\
 	u8                              start_field_bit_offset;/* Bit offset within first field datum (0-63) */\
-	u8                              access_length;	/* For serial regions/fields */
+	u8                              access_length	/* For serial regions/fields */
 
 
 /* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
 
 struct acpi_object_field_common {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
 };
 
 struct acpi_object_region_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u16 resource_length;
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	u16 resource_length;
 	union acpi_operand_object *region_obj;	/* Containing op_region object */
 	u8 *resource_buffer;	/* resource_template for serial regions/fields */
 	u16 pin_number_index;	/* Index relative to previous Connection/Template */
@@ -244,16 +267,20 @@ struct acpi_object_region_field {
 };
 
 struct acpi_object_bank_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Containing op_region object */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	union acpi_operand_object *region_obj;	/* Containing op_region object */
 	union acpi_operand_object *bank_obj;	/* bank_select Register object */
 };
 
 struct acpi_object_index_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO
-	    /*
-	     * No "RegionObj" pointer needed since the Index and Data registers
-	     * are each field definitions unto themselves.
-	     */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+
+	/*
+	 * No "RegionObj" pointer needed since the Index and Data registers
+	 * are each field definitions unto themselves.
+	 */
 	union acpi_operand_object *index_obj;	/* Index register */
 	union acpi_operand_object *data_obj;	/* Data register */
 };
@@ -261,7 +288,9 @@ struct acpi_object_index_field {
 /* The buffer_field is different in that it is part of a Buffer, not an op_region */
 
 struct acpi_object_buffer_field {
-	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u8 is_create_field;	/* Special case for objects created by create_field() */
+	ACPI_OBJECT_COMMON_HEADER;
+	ACPI_COMMON_FIELD_INFO;
+	u8 is_create_field;	/* Special case for objects created by create_field() */
 	union acpi_operand_object *buffer_obj;	/* Containing Buffer object */
 };
 
@@ -272,7 +301,8 @@ struct acpi_object_buffer_field {
  *****************************************************************************/
 
 struct acpi_object_notify_handler {
-	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;	/* Parent device */
+	ACPI_OBJECT_COMMON_HEADER;
+	struct acpi_namespace_node *node;	/* Parent device */
 	u32 handler_type;	/* Type: Device/System/Both */
 	acpi_notify_handler handler;	/* Handler address */
 	void *context;
@@ -280,7 +310,8 @@ struct acpi_object_notify_handler {
 };
 
 struct acpi_object_addr_handler {
-	ACPI_OBJECT_COMMON_HEADER u8 space_id;
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 space_id;
 	u8 handler_flags;
 	acpi_adr_space_handler handler;
 	struct acpi_namespace_node *node;	/* Parent device */
@@ -307,7 +338,8 @@ struct acpi_object_addr_handler {
  * The Reference.Class differentiates these types.
  */
 struct acpi_object_reference {
-	ACPI_OBJECT_COMMON_HEADER u8 class;	/* Reference Class */
+	ACPI_OBJECT_COMMON_HEADER;
+	u8 class;		/* Reference Class */
 	u8 target_type;		/* Used for Index Op */
 	u8 resolved;		/* Reference has been resolved to a value */
 	void *object;		/* name_op=>HANDLE to obj, index_op=>union acpi_operand_object */
@@ -340,7 +372,8 @@ typedef enum {
  * Currently: Region and field_unit types
  */
 struct acpi_object_extra {
-	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
+	ACPI_OBJECT_COMMON_HEADER;
+	struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
 	struct acpi_namespace_node *scope_node;
 	void *region_context;	/* Region-specific data */
 	u8 *aml_start;
@@ -350,14 +383,16 @@ struct acpi_object_extra {
 /* Additional data that can be attached to namespace nodes */
 
 struct acpi_object_data {
-	ACPI_OBJECT_COMMON_HEADER acpi_object_handler handler;
+	ACPI_OBJECT_COMMON_HEADER;
+	acpi_object_handler handler;
 	void *pointer;
 };
 
 /* Structure used when objects are cached for reuse */
 
 struct acpi_object_cache_list {
-	ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;	/* Link for object cache and internal lists */
+	ACPI_OBJECT_COMMON_HEADER;
+	union acpi_operand_object *next;	/* Link for object cache and internal lists */
 };
 
 /******************************************************************************
-- 
2.35.3





