Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0746E88CF
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 05:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDTDmp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 23:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDTDmn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 23:42:43 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9943599
        for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2023 20:42:41 -0700 (PDT)
X-UUID: d0abccea0e08490681e91a066b505718-20230420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:0992aef7-6b84-42ad-9fdd-54d1af96cc30,IP:10,
        URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:1
X-CID-INFO: VERSION:1.1.22,REQID:0992aef7-6b84-42ad-9fdd-54d1af96cc30,IP:10,UR
        L:0,TC:0,Content:-25,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:1
X-CID-META: VersionHash:120426c,CLOUDID:28a08eeb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:2304201142300J8D93HI,BulkQuantity:0,Recheck:0,SF:17|19|43|24|102,TC:
        nil,Content:0,EDM:5,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d0abccea0e08490681e91a066b505718-20230420
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
        (envelope-from <guodongtai@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1420089569; Thu, 20 Apr 2023 11:42:28 +0800
From:   George Guo <guodongtai@kylinos.cn>
To:     guodongtai@kylinos.cn
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        rafael.j.wysocki@intel.com, robert.moore@intel.com
Subject: [PATCH v2] ACPICA: Modify ACPI_STATE_COMMON and put it in a single line
Date:   Thu, 20 Apr 2023 11:42:27 +0800
Message-Id: <20230420034227.4088760-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410144846.1959224-1-guodongtai@kylinos.cn>
References: <20230410144846.1959224-1-guodongtai@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Avoid trailing semicolons in macro, and it's not readable to put macro ACPI_STATE_COMMON and other
variables in the same line.
So modify the macro and just put it in a single line.

Link: https://github.com/acpica/acpica/pull/870
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 drivers/acpi/acpica/aclocal.h | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 901b1543b869..cb757ac2c22e 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -560,25 +560,28 @@ struct acpi_field_info {
 	u8                              descriptor_type; /* To differentiate various internal objs */\
 	u8                              flags; \
 	u16                             value; \
-	u16                             state;
+	u16                             state
 
 	/* There are 2 bytes available here until the next natural alignment boundary */
 
 struct acpi_common_state {
-ACPI_STATE_COMMON};
+	ACPI_STATE_COMMON;
+};
 
 /*
  * Update state - used to traverse complex objects such as packages
  */
 struct acpi_update_state {
-	ACPI_STATE_COMMON union acpi_operand_object *object;
+	ACPI_STATE_COMMON;
+	union acpi_operand_object *object;
 };
 
 /*
  * Pkg state - used to traverse nested package structures
  */
 struct acpi_pkg_state {
-	ACPI_STATE_COMMON u32 index;
+	ACPI_STATE_COMMON;
+	u32 index;
 	union acpi_operand_object *source_object;
 	union acpi_operand_object *dest_object;
 	struct acpi_walk_state *walk_state;
@@ -591,7 +594,8 @@ struct acpi_pkg_state {
  * Allows nesting of these constructs
  */
 struct acpi_control_state {
-	ACPI_STATE_COMMON u16 opcode;
+	ACPI_STATE_COMMON;
+	u16 opcode;
 	union acpi_parse_object *predicate_op;
 	u8 *aml_predicate_start;	/* Start of if/while predicate */
 	u8 *package_end;	/* End of if/while block */
@@ -602,11 +606,13 @@ struct acpi_control_state {
  * Scope state - current scope during namespace lookups
  */
 struct acpi_scope_state {
-	ACPI_STATE_COMMON struct acpi_namespace_node *node;
+	ACPI_STATE_COMMON;
+	struct acpi_namespace_node *node;
 };
 
 struct acpi_pscope_state {
-	ACPI_STATE_COMMON u32 arg_count;	/* Number of fixed arguments */
+	ACPI_STATE_COMMON;
+	u32 arg_count;	/* Number of fixed arguments */
 	union acpi_parse_object *op;	/* Current op being parsed */
 	u8 *arg_end;		/* Current argument end */
 	u8 *pkg_end;		/* Current package end */
@@ -618,7 +624,8 @@ struct acpi_pscope_state {
  * states are created when there are nested control methods executing.
  */
 struct acpi_thread_state {
-	ACPI_STATE_COMMON u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
+	ACPI_STATE_COMMON;
+	u8 current_sync_level;	/* Mutex Sync (nested acquire) level */
 	struct acpi_walk_state *walk_state_list;	/* Head of list of walk_states for this thread */
 	union acpi_operand_object *acquired_mutex_list;	/* List of all currently acquired mutexes */
 	acpi_thread_id thread_id;	/* Running thread ID */
@@ -629,8 +636,8 @@ struct acpi_thread_state {
  * AML arguments
  */
 struct acpi_result_values {
-	ACPI_STATE_COMMON
-	    union acpi_operand_object *obj_desc[ACPI_RESULTS_FRAME_OBJ_NUM];
+	ACPI_STATE_COMMON;
+	union acpi_operand_object *obj_desc[ACPI_RESULTS_FRAME_OBJ_NUM];
 };
 
 typedef
@@ -652,7 +659,8 @@ struct acpi_global_notify_handler {
  * handler/dispatcher.
  */
 struct acpi_notify_info {
-	ACPI_STATE_COMMON u8 handler_list_id;
+	ACPI_STATE_COMMON;
+	u8 handler_list_id;
 	struct acpi_namespace_node *node;
 	union acpi_operand_object *handler_list_head;
 	struct acpi_global_notify_handler *global;
-- 
2.34.1

