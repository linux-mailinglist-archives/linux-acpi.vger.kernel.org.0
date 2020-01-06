Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEEC13162C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jan 2020 17:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgAFQhn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jan 2020 11:37:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34148 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFQhn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jan 2020 11:37:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so42912269qtz.1
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jan 2020 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+jSOrz0ggOnULHRyjZYHEWOfyv+l6rhjy3cWQ3mwrg=;
        b=RAyqu9ZLSyNlyDDhChjFRkyveS5QKwUZJe2h0lZR6/TQPI0+6XpML62Vch9hdHaMeL
         /TcMgkfKPU5NIubrIi10QSrVv3n0gGYW4ekh4nEOEeAO9LhddRcOUNn1QT92sVL2qbRz
         coaYe2jWakCCkzsDg5C0kiVQiYAI+nLLU6MZJ9EqgMo/hhJUZ5f9CzeAtz9W/An/tcY4
         lJxl+9FZnuCgQb4MoAXLw1vK2iIZCBUVfXOQrSpknWaA8wSUU0O9CjRP910Ezwj1CyAS
         Gy4FpCOtKZpkSyeYGd1hgw3f94FqfuCuTKMWrNb+NEUhRt4yQ29cPVuEdi4jIp251wPX
         0/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+jSOrz0ggOnULHRyjZYHEWOfyv+l6rhjy3cWQ3mwrg=;
        b=niNbGcq33Ym3SP5IPda8x0NWaBkyHfHZO8ezEn0sR+5ZIfcd+4avsnWqDMwGhafzcy
         HgUZKQMlcpN9ZhFeqlB9vO9Cm4utJBW/wggee5ffg4WyVZR3wHSBDKOzqFzjNw8xZI+E
         TV2EAWMeEp/S8w+Vg3ymkxBCyO7yZhOU4eVvcYjV2ux2sceUwy0AcZIARpp4tNKL1ASM
         c4rPGcGcL9UayZCkfpFBXLDmd0kgBhRmGiPSSgPiSG8aB1hCdrBpzkW+HscwO6oOUflG
         N23LK8HXg/2stDc/a5HnT8W7syHOuQvowm4CaTN/roul4Mg6GWXg1kV+j6Ecjrz5q5GL
         o//g==
X-Gm-Message-State: APjAAAX0IxD0bHfM745CT45aSHDZazBis4NTnnmtnEgzkvufzUR0XpZq
        36khYzK/4/gN9UJFv9xWgZ/sIA==
X-Google-Smtp-Source: APXvYqxtlnL/pyN9q3EiFstOPI51sTUm5NCbQtajWd3B5j+kI6sEpgpIdpIC6PFYRD7ynqiscM/ypw==
X-Received: by 2002:ac8:16ca:: with SMTP id y10mr79055212qtk.340.1578328662546;
        Mon, 06 Jan 2020 08:37:42 -0800 (PST)
Received: from ovpn-121-70.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l85sm20924871qke.103.2020.01.06.08.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:37:41 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     rafael.j.wysocki@intel.com
Cc:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] drivers/base/test: fix global-out-of-bounds error
Date:   Mon,  6 Jan 2020 11:37:35 -0500
Message-Id: <20200106163735.1826-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit c032ace71c29 ("software node: add basic tests for property
entries") introduced a global-out-of-bounds error because it forgot to
add a terminator of "nodes "for software_node_register_nodes() to
process.

 	# Subtest: property-entry
 	1..7
 	ok 1 - pe_test_uints
 	ok 2 - pe_test_uint_arrays
 	ok 3 - pe_test_strings
 	ok 4 - pe_test_bool
 	ok 5 - pe_test_move_inline_u8
 	ok 6 - pe_test_move_inline_str
 ==================================================================
 BUG: KASAN: global-out-of-bounds in
 software_node_register_nodes+0x41/0x80
 Read of size 8 at addr ffffffff989ef250 by task kunit_try_catch/316

 CPU: 17 PID: 316 Comm: kunit_try_catch Not tainted
 5.5.0-rc4-next-20200106+ #1
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
 03/09/2018
 Call Trace:
  dump_stack+0xa0/0xea
  print_address_description.constprop.5.cold.7+0x64/0x384
  __kasan_report.cold.8+0x7a/0xc0
  kasan_report+0x12/0x20
  __asan_load8+0x71/0xa0
  software_node_register_nodes+0x41/0x80
  pe_test_reference+0x1eb/0x1200
  kunit_try_run_case+0x6b/0xd1
  kunit_generic_run_threadfn_adapter+0x29/0x50
  kthread+0x1e6/0x210
  ret_from_fork+0x27/0x50

 The buggy address belongs to the variable:
  nodes.21544+0x30/0x920

 Memory state around the buggy address:
  ffffffff989ef100: fa fa fa fa 00 04 fa fa fa fa fa fa 00 00 00 00
  ffffffff989ef180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffffff989ef200: fa fa fa fa 00 00 00 00 00 00 fa fa fa fa fa fa
                                                  ^
  ffffffff989ef280: 00 06 fa fa fa fa fa fa 00 00 04 fa fa fa fa fa
  ffffffff989ef300: 00 00 fa fa fa fa fa fa 00 05 fa fa fa fa fa fa
 ==================================================================
 Disabling lock debugging due to kernel taint
 	ok 7 - pe_test_reference
 ok 8 - property-entry

Fixes: c032ace71c29 ("software node: add basic tests for property entries")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/base/test/property-entry-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index da812834b631..abe03315180f 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -366,6 +366,7 @@ static void pe_test_reference(struct kunit *test)
 	static const struct software_node nodes[] = {
 		{ .name = "1", },
 		{ .name = "2", },
+		{ }
 	};
 
 	static const struct software_node_ref_args refs[] = {
-- 
2.21.0 (Apple Git-122.2)

