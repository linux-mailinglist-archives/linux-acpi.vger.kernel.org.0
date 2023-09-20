Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2577B7A7482
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Sep 2023 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjITHoL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Sep 2023 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjITHoK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Sep 2023 03:44:10 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC5DE;
        Wed, 20 Sep 2023 00:44:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2F2E060157;
        Wed, 20 Sep 2023 09:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695195829; bh=+1+lWp07mJQBiLck3AusgoT8+We21cYFD6KbxGYygBA=;
        h=From:To:Cc:Subject:Date:From;
        b=UtfxYKmEsLmEyRY9je27BUc9bm2H+j8sOJjUUAr1AVt5qugKj1U1+Wecm9ghX7u9a
         Zh/foZ3H3C9sK0cc6cUxdv+3QHaZH/r75biBJSHRKZP4Kh1DfECahmGYPqUhJxqIba
         PsrvNzmCnCLtqvof0qRfGwfP6VlydCKdTdRhjOY/1eiG1Oz0D5ZD7u6um9YCHI7r6E
         CSj8hvl0So5SCNay209qR+taWG3fkFaOGikVtPvt/byOl8dApl8D9Xm0XV4zDGLaW7
         CNq4Zo8ZW0dWlLLe5oIY7+CTwC6eSjpHyGBcSx77i1/DcUPaD54KE0VrUjRPny7xq+
         cjmBlSndiud2w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id np-neNR6A0IQ; Wed, 20 Sep 2023 09:43:46 +0200 (CEST)
Received: from defiant.home (78-2-200-2.adsl.net.t-com.hr [78.2.200.2])
        by domac.alu.hr (Postfix) with ESMTPSA id 9E7CB60152;
        Wed, 20 Sep 2023 09:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695195826; bh=+1+lWp07mJQBiLck3AusgoT8+We21cYFD6KbxGYygBA=;
        h=From:To:Cc:Subject:Date:From;
        b=sSMugMNbzSihde1J0x28p9IP5WP0u7yn/LkWhXKOeSANjfhVHhiCseWAZzEkFeNU+
         bWiCAqfvkF5veQ5c9lL0F3qslmZgdqsCLMYXHgYWxPjt6T+LSTUr80JbCvv1yOg75W
         Ol8e2oCIAvdS6kSgDp/N2+qRo4Uwy+3m8ZoS5I/rvKahvqAHn3b6KkN7IrxL65KrwS
         kcsOMOQP3MaD3k9iDlhik13R/wN/L1WK83dhejQrD/1Pb2X6n9dG+2Nvb2ZmE7ucMS
         3bJDTmtKNXxmZVkRLEkhiQmDykaRi6xY+eCzcr/5hpjxYFUJuA+5nkEGARWrcVqWnj
         4MYd2EU3LUf/Q==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Jung-uk Kim <jkim@FreeBSD.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] acpica: use spinlocks to fix the data-races reported by the KCSAN
Date:   Wed, 20 Sep 2023 09:41:59 +0200
Message-Id: <20230920074158.3605-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

KCSAN reported hundreds of instances of data-races in ACPICA like this one:

[    6.994149] ==================================================================
[    6.994443] BUG: KCSAN: data-race in acpi_ut_status_exit / acpi_ut_trace

[    6.994795] write to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 2:
[    6.994944] acpi_ut_status_exit (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/utdebug.c:467)
[    6.994957] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:563)
[    6.994968] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwxface.c:171)
[    6.994980] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:511)
[    6.994990] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:644 (discriminator 1))
[    6.995000] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:695)
[    6.995010] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:267)
[    6.995019] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
[    6.995027] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
[    6.995038] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
[    6.995046] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
[    6.995055] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
[    6.995066] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)

[    6.995121] read to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 9:
[    6.995267] acpi_ut_trace (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/utdebug.c:263)
[    6.995279] acpi_hw_validate_io_request (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwvalid.c:101)
[    6.995291] acpi_hw_read_port (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwvalid.c:202)
[    6.995303] acpi_hw_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:251)
[    6.995313] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:725 /home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:499)
[    6.995325] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwxface.c:171)
[    6.995336] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:511)
[    6.995346] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:644 (discriminator 1))
[    6.995356] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:695)
[    6.995366] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:267)
[    6.995375] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
[    6.995383] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
[    6.995394] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
[    6.995402] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
[    6.995411] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
[    6.995422] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)

[    6.995476] value changed: 0x00000004 -> 0x00000002

[    6.995629] Reported by Kernel Concurrency Sanitizer on:
[    6.995748] CPU: 9 PID: 0 Comm: swapper/9 Not tainted 6.6.0-rc2-kcsan-00003-g16819584c239-dirty #21
[    6.995758] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[    6.995765] ==================================================================

Please find the complete list at: https://domac.alu.unizg.hr/~mtodorov/linux/patches/acpica_utdebug/acpi_ut_status_exit.log.xz

A number of unprotected increments:

        acpi_gbl_nesting_level++;

and conditional statements:

        if (acpi_gbl_nesting_level) {
                acpi_gbl_nesting_level--;
        }

no longer work in SMP environment.

Proper locking like

        spin_lock(&acpi_utdebug_lock);
        acpi_gbl_nesting_level++;
        spin_unlock(&acpi_utdebug_lock);

and

        spin_lock(&acpi_utdebug_lock);
        if (acpi_gbl_nesting_level) {
                acpi_gbl_nesting_level--;
        }
        spin_unlock(&acpi_utdebug_lock);

makes these data-races go away.

Additionally, READ_ONCE() or WRITE_ONCE() is required with the global variable
acpi_gbl_nesting_level to prevent unwanted read or write reordering or other funny
stuff the optmisers do.

The patch eliminates KCSAN BUG warnings.

Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Fixes: 6be2d72b18649 ("ACPICA: Update for a few debug output statements")
Fixes: bf9b448ef8430 ("ACPICA: Debug output: Do not emit function nesting level for kernel build.")
Fixes: 6e875fa0480c1 ("ACPICA: Debugger: fix slight indentation issue")
Fixes: ^1da177e4c3f4 ("Initial git repository build.")
Cc: Jung-uk Kim <jkim@FreeBSD.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Erik Kaneda <erik.kaneda@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linuxfoundation.org
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309201331.S2c1JL2h-lkp@intel.com/
---
v1 -> v2:
 Moved the declaration of 'u32 nesting_level' inside #ifdef ACPI_APPLICATION ... #endif
 according to the unused variable warning of the kernel test robot.

v1:
 Preliminary RFC version of the patch.

 drivers/acpi/acpica/utdebug.c | 40 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index c5f6c85a3a09..1faf7dc144f0 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -16,6 +16,8 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utdebug")
 
+static DEFINE_SPINLOCK(acpi_utdebug_lock);
+
 #ifdef ACPI_DEBUG_OUTPUT
 static acpi_thread_id acpi_gbl_previous_thread_id = (acpi_thread_id) 0xFFFFFFFF;
 static const char *acpi_gbl_function_entry_prefix = "----Entry";
@@ -60,13 +62,16 @@ void acpi_ut_init_stack_ptr_trace(void)
 void acpi_ut_track_stack_ptr(void)
 {
 	acpi_size current_sp;
+	u32 nesting_level;
 
 	if (&current_sp < acpi_gbl_lowest_stack_pointer) {
 		acpi_gbl_lowest_stack_pointer = &current_sp;
 	}
 
-	if (acpi_gbl_nesting_level > acpi_gbl_deepest_nesting) {
-		acpi_gbl_deepest_nesting = acpi_gbl_nesting_level;
+	nesting_level = READ_ONCE(acpi_gbl_nesting_level);
+
+	if (nesting_level > acpi_gbl_deepest_nesting) {
+		acpi_gbl_deepest_nesting = nesting_level;
 	}
 }
 
@@ -136,6 +141,7 @@ acpi_debug_print(u32 requested_debug_level,
 	va_list args;
 #ifdef ACPI_APPLICATION
 	int fill_count;
+	u32 nesting_level;
 #endif
 
 	/* Check if debug output enabled */
@@ -156,7 +162,7 @@ acpi_debug_print(u32 requested_debug_level,
 		}
 
 		acpi_gbl_previous_thread_id = thread_id;
-		acpi_gbl_nesting_level = 0;
+		WRITE_ONCE(acpi_gbl_nesting_level, 0);
 	}
 
 	/*
@@ -176,14 +182,16 @@ acpi_debug_print(u32 requested_debug_level,
 		acpi_os_printf("[%u] ", (u32)thread_id);
 	}
 
-	fill_count = 48 - acpi_gbl_nesting_level -
+	fill_count = 48 - READ_ONCE(acpi_gbl_nesting_level) -
 	    strlen(acpi_ut_trim_function_name(function_name));
 	if (fill_count < 0) {
 		fill_count = 0;
 	}
 
+	nesting_level = READ_ONCE(acpi_gbl_nesting_level);
+
 	acpi_os_printf("[%02d] %*s",
-		       acpi_gbl_nesting_level, acpi_gbl_nesting_level + 1, " ");
+		       nesting_level, nesting_level + 1, " ");
 	acpi_os_printf("%s%*s: ",
 		       acpi_ut_trim_function_name(function_name), fill_count,
 		       " ");
@@ -260,7 +268,10 @@ acpi_ut_trace(u32 line_number,
 	      const char *module_name, u32 component_id)
 {
 
+	spin_lock(&acpi_utdebug_lock);
 	acpi_gbl_nesting_level++;
+	spin_unlock(&acpi_utdebug_lock);
+
 	acpi_ut_track_stack_ptr();
 
 	/* Check if enabled up-front for performance */
@@ -298,7 +309,10 @@ acpi_ut_trace_ptr(u32 line_number,
 		  u32 component_id, const void *pointer)
 {
 
+	spin_lock(&acpi_utdebug_lock);
 	acpi_gbl_nesting_level++;
+	spin_unlock(&acpi_utdebug_lock);
+
 	acpi_ut_track_stack_ptr();
 
 	/* Check if enabled up-front for performance */
@@ -334,7 +348,10 @@ acpi_ut_trace_str(u32 line_number,
 		  const char *module_name, u32 component_id, const char *string)
 {
 
+	spin_lock(&acpi_utdebug_lock);
 	acpi_gbl_nesting_level++;
+	spin_unlock(&acpi_utdebug_lock);
+
 	acpi_ut_track_stack_ptr();
 
 	/* Check if enabled up-front for performance */
@@ -370,7 +387,10 @@ acpi_ut_trace_u32(u32 line_number,
 		  const char *module_name, u32 component_id, u32 integer)
 {
 
+	spin_lock(&acpi_utdebug_lock);
 	acpi_gbl_nesting_level++;
+	spin_unlock(&acpi_utdebug_lock);
+
 	acpi_ut_track_stack_ptr();
 
 	/* Check if enabled up-front for performance */
@@ -414,9 +434,11 @@ acpi_ut_exit(u32 line_number,
 				 acpi_gbl_function_exit_prefix);
 	}
 
+	spin_lock(&acpi_utdebug_lock);
 	if (acpi_gbl_nesting_level) {
 		acpi_gbl_nesting_level--;
 	}
+	spin_unlock(&acpi_utdebug_lock);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_exit)
@@ -463,9 +485,11 @@ acpi_ut_status_exit(u32 line_number,
 		}
 	}
 
+	spin_lock(&acpi_utdebug_lock);
 	if (acpi_gbl_nesting_level) {
 		acpi_gbl_nesting_level--;
 	}
+	spin_unlock(&acpi_utdebug_lock);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_status_exit)
@@ -502,9 +526,11 @@ acpi_ut_value_exit(u32 line_number,
 				 ACPI_FORMAT_UINT64(value));
 	}
 
+	spin_lock(&acpi_utdebug_lock);
 	if (acpi_gbl_nesting_level) {
 		acpi_gbl_nesting_level--;
 	}
+	spin_unlock(&acpi_utdebug_lock);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_ut_value_exit)
@@ -540,9 +566,11 @@ acpi_ut_ptr_exit(u32 line_number,
 				 acpi_gbl_function_exit_prefix, ptr);
 	}
 
+	spin_lock(&acpi_utdebug_lock);
 	if (acpi_gbl_nesting_level) {
 		acpi_gbl_nesting_level--;
 	}
+	spin_unlock(&acpi_utdebug_lock);
 }
 
 /*******************************************************************************
@@ -577,9 +605,11 @@ acpi_ut_str_exit(u32 line_number,
 				 acpi_gbl_function_exit_prefix, string);
 	}
 
+	spin_lock(&acpi_utdebug_lock);
 	if (acpi_gbl_nesting_level) {
 		acpi_gbl_nesting_level--;
 	}
+	spin_unlock(&acpi_utdebug_lock);
 }
 
 /*******************************************************************************
-- 
2.34.1

