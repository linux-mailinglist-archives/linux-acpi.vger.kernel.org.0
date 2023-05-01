Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93A6F2E05
	for <lists+linux-acpi@lfdr.de>; Mon,  1 May 2023 05:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjEADSf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 30 Apr 2023 23:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjEADRJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Apr 2023 23:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD536A7C;
        Sun, 30 Apr 2023 20:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 667E06187E;
        Mon,  1 May 2023 03:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D66C4339B;
        Mon,  1 May 2023 03:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910420;
        bh=4pXhClnOYObZyckT+RBFsOGp8JDZyOj5VRZewBxPN/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJgYgwhO9SJrI6vVmu/c976T3KwEIZf7iK0odZZ/UHVHEToNp1/0tfoDyik04JHe4
         EF4awzqMmWyhbZy4PBtqHyIOkFGAojWa6+a4WoNT13Nknw/9Hu9EvsVOnCUtsMuzPO
         L9OeJ5BnxDEFIXkAvdIijIIv8TrsYUGQgh6/cIh0vo2g8zMudr97ck5c4vNCAezufc
         HDk65U5uec0CMmLOxnFE0dG7d+R/lqa/ZsZAa6mIcp0zZ2bWsAGGJkXCt/KazTdy3t
         BmFxBbLzMg31O0A9VoWNSn+BCg37kSSCP4MCUGUeGhIAFVvJolnaPRgcjTY5Fcwf+U
         wV6NBFIf32WNA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tamir Duberstein <tamird@google.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Subject: [PATCH AUTOSEL 4.14 5/6] ACPICA: Avoid undefined behavior: applying zero offset to null pointer
Date:   Sun, 30 Apr 2023 23:06:51 -0400
Message-Id: <20230501030653.3255321-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030653.3255321-1-sashal@kernel.org>
References: <20230501030653.3255321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tamir Duberstein <tamird@google.com>

[ Upstream commit 05bb0167c80b8f93c6a4e0451b7da9b96db990c2 ]

ACPICA commit 770653e3ba67c30a629ca7d12e352d83c2541b1e

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x000021e4213b3302 in acpi_ds_init_aml_walk(struct acpi_walk_state*, union acpi_parse_object*, struct acpi_namespace_node*, u8*, u32, struct acpi_evaluate_info*, u8) ../../third_party/acpica/source/components/dispatcher/dswstate.c:682 <platform-bus-x86.so>+0x233302
  #1.2  0x000020d0f660777f in ubsan_get_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x3d77f
  #1.1  0x000020d0f660777f in maybe_print_stack_trace() compiler-rt/lib/ubsan/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x3d77f
  #1    0x000020d0f660777f in ~scoped_report() compiler-rt/lib/ubsan/ubsan_diag.cpp:387 <libclang_rt.asan.so>+0x3d77f
  #2    0x000020d0f660b96d in handlepointer_overflow_impl() compiler-rt/lib/ubsan/ubsan_handlers.cpp:809 <libclang_rt.asan.so>+0x4196d
  #3    0x000020d0f660b50d in compiler-rt/lib/ubsan/ubsan_handlers.cpp:815 <libclang_rt.asan.so>+0x4150d
  #4    0x000021e4213b3302 in acpi_ds_init_aml_walk(struct acpi_walk_state*, union acpi_parse_object*, struct acpi_namespace_node*, u8*, u32, struct acpi_evaluate_info*, u8) ../../third_party/acpica/source/components/dispatcher/dswstate.c:682 <platform-bus-x86.so>+0x233302
  #5    0x000021e4213e2369 in acpi_ds_call_control_method(struct acpi_thread_state*, struct acpi_walk_state*, union acpi_parse_object*) ../../third_party/acpica/source/components/dispatcher/dsmethod.c:605 <platform-bus-x86.so>+0x262369
  #6    0x000021e421437fac in acpi_ps_parse_aml(struct acpi_walk_state*) ../../third_party/acpica/source/components/parser/psparse.c:550 <platform-bus-x86.so>+0x2b7fac
  #7    0x000021e4214464d2 in acpi_ps_execute_method(struct acpi_evaluate_info*) ../../third_party/acpica/source/components/parser/psxface.c:244 <platform-bus-x86.so>+0x2c64d2
  #8    0x000021e4213aa052 in acpi_ns_evaluate(struct acpi_evaluate_info*) ../../third_party/acpica/source/components/namespace/nseval.c:250 <platform-bus-x86.so>+0x22a052
  #9    0x000021e421413dd8 in acpi_ns_init_one_device(acpi_handle, u32, void*, void**) ../../third_party/acpica/source/components/namespace/nsinit.c:735 <platform-bus-x86.so>+0x293dd8
  #10   0x000021e421429e98 in acpi_ns_walk_namespace(acpi_object_type, acpi_handle, u32, u32, acpi_walk_callback, acpi_walk_callback, void*, void**) ../../third_party/acpica/source/components/namespace/nswalk.c:298 <platform-bus-x86.so>+0x2a9e98
  #11   0x000021e4214131ac in acpi_ns_initialize_devices(u32) ../../third_party/acpica/source/components/namespace/nsinit.c:268 <platform-bus-x86.so>+0x2931ac
  #12   0x000021e42147c40d in acpi_initialize_objects(u32) ../../third_party/acpica/source/components/utilities/utxfinit.c:304 <platform-bus-x86.so>+0x2fc40d
  #13   0x000021e42126d603 in acpi::acpi_impl::initialize_acpi(acpi::acpi_impl*) ../../src/devices/board/lib/acpi/acpi-impl.cc:224 <platform-bus-x86.so>+0xed603

Add a simple check that avoids incrementing a pointer by zero, but
otherwise behaves as before. Note that our findings are against ACPICA
20221020, but the same code exists on master.

Link: https://github.com/acpica/acpica/commit/770653e3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dswstate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
index da111a1f5bfbc..6eaf2a01034ea 100644
--- a/drivers/acpi/acpica/dswstate.c
+++ b/drivers/acpi/acpica/dswstate.c
@@ -610,9 +610,14 @@ acpi_ds_init_aml_walk(struct acpi_walk_state *walk_state,
 	ACPI_FUNCTION_TRACE(ds_init_aml_walk);
 
 	walk_state->parser_state.aml =
-	    walk_state->parser_state.aml_start = aml_start;
-	walk_state->parser_state.aml_end =
-	    walk_state->parser_state.pkg_end = aml_start + aml_length;
+	    walk_state->parser_state.aml_start =
+	    walk_state->parser_state.aml_end =
+	    walk_state->parser_state.pkg_end = aml_start;
+	/* Avoid undefined behavior: applying zero offset to null pointer */
+	if (aml_length != 0) {
+		walk_state->parser_state.aml_end += aml_length;
+		walk_state->parser_state.pkg_end += aml_length;
+	}
 
 	/* The next_op of the next_walk will be the beginning of the method */
 
-- 
2.39.2

