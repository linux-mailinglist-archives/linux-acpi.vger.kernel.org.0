Return-Path: <linux-acpi+bounces-12470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C54DA72093
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1E7A4251
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430AE264FBB;
	Wed, 26 Mar 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RYvmiAC3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA9263F41;
	Wed, 26 Mar 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023532; cv=none; b=lpTeSEOqK+NsPWDl94CCkUNkf4WMULoH56c856kU24aOWrqXMMxsEeF16xld01Q23uon/18G7zEdpt1zV/Sr6KjVKeDOwk36nf3J3LknONGw1/MsOX8r3aNmYMmoUzlNmu+X81DtQW/ltpD9aSC28c0dSHpU+FQzIZMzeAZB6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023532; c=relaxed/simple;
	bh=F4E/1lTS8s6k1wL3NJeJIO5JdhTH3uH3eeUG0h8M6do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCJPw1pA+n/dl91kfQSdwYGg2K7gMcTPKEqBbb+L5ZPWAW9MG6DMarPVRkKQpjmTQx5eYEVpmlp8BDBegfXyFXzrbCfp7uAmYUQV7v79iKCg59BEwuUwz1rWhtuLebL2QQdeZa1L1+FoPmnneDQ938j2XsSBMBUI4c+qAoPNZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RYvmiAC3; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 07852fae254ae380; Wed, 26 Mar 2025 21:12:08 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 64EB67F6388;
	Wed, 26 Mar 2025 21:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019928;
	bh=F4E/1lTS8s6k1wL3NJeJIO5JdhTH3uH3eeUG0h8M6do=;
	h=From:Subject:Date;
	b=RYvmiAC3yVnRUTtlD2pTcv5PHfNR2ZvUSPF9bmIZGKITrnnpBThKIbjAN/cPM7Qw8
	 IWvIUKnRgIa5KtXe0wCeiy1RRK+4Welv+2j16irWg0fpQJg7YPH+LidXVivUZ0yg84
	 0HF72Z8Y4z3wkbTr9rDEcrb2bXbq4xYpkN0RdcIeHA1mmjQxi7rukixgDaQu9qb4dc
	 PmJNluHM6JMRwf3X5dKoUBTMpfCEtqgH3xnmnWxEGlE3fK5ytkQ9xgbp1Ug35p2A9V
	 7hZax9ok2FCCbfl+TjN5I1os363ObN/juuYzhrBWc47E0P7h92xzjCQNnXgnLXVaPT
	 RZZUbT7XreCNw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 2/8] ACPICA: fix acpi parse and parseext cache leaks
Date: Wed, 26 Mar 2025 21:06:21 +0100
Message-ID: <2363774.ElGaqSPkdT@rjwysocki.net>
In-Reply-To: <5873907.DvuYhMxLoT@rjwysocki.net>
References: <5873907.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffelteekjeevteffleelvddvudffieejfedttefhfeejlefggeeivdefudeihfeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

=46rom: Seunghun Han <kkamagui@gmail.com>

ACPICA commit 8829e70e1360c81e7a5a901b5d4f48330e021ea5

I'm Seunghun Han, and I work for National Security Research Institute of
South Korea.

I have been doing a research on ACPI and found an ACPI cache leak in ACPI
early abort cases.

Boot log of ACPI cache leak is as follows:
[    0.352414] ACPI: Added _OSI(Module Device)
[    0.353182] ACPI: Added _OSI(Processor Device)
[    0.353182] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.353182] ACPI: Added _OSI(Processor Aggregator Device)
[    0.356028] ACPI: Unable to start the ACPI Interpreter
[    0.356799] ACPI Error: Could not remove SCI handler (20170303/evmisc-28=
1)
[    0.360215] kmem_cache_destroy Acpi-State: Slab cache still has objects
[    0.360648] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #10
[    0.361273] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.361873] Call Trace:
[    0.362243]  ? dump_stack+0x5c/0x81
[    0.362591]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.362944]  ? acpi_sleep_proc_init+0x27/0x27
[    0.363296]  ? acpi_os_delete_cache+0xa/0x10
[    0.363646]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.364000]  ? acpi_terminate+0xa/0x14
[    0.364000]  ? acpi_init+0x2af/0x34f
[    0.364000]  ? __class_create+0x4c/0x80
[    0.364000]  ? video_setup+0x7f/0x7f
[    0.364000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.364000]  ? do_one_initcall+0x4e/0x1a0
[    0.364000]  ? kernel_init_freeable+0x189/0x20a
[    0.364000]  ? rest_init+0xc0/0xc0
[    0.364000]  ? kernel_init+0xa/0x100
[    0.364000]  ? ret_from_fork+0x25/0x30

I analyzed this memory leak in detail. I found that =E2=80=9CAcpi-State=E2=
=80=9D cache and
=E2=80=9CAcpi-Parse=E2=80=9D cache were merged because the size of cache ob=
jects was same
slab cache size.

I finally found =E2=80=9CAcpi-Parse=E2=80=9D cache and =E2=80=9CAcpi-parse_=
ext=E2=80=9D cache were leaked
using SLAB_NEVER_MERGE flag in kmem_cache_create() function.

Real ACPI cache leak point is as follows:
[    0.360101] ACPI: Added _OSI(Module Device)
[    0.360101] ACPI: Added _OSI(Processor Device)
[    0.360101] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.361043] ACPI: Added _OSI(Processor Aggregator Device)
[    0.364016] ACPI: Unable to start the ACPI Interpreter
[    0.365061] ACPI Error: Could not remove SCI handler (20170303/evmisc-28=
1)
[    0.368174] kmem_cache_destroy Acpi-Parse: Slab cache still has objects
[    0.369332] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.371256] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.372000] Call Trace:
[    0.372000]  ? dump_stack+0x5c/0x81
[    0.372000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? acpi_os_delete_cache+0xa/0x10
[    0.372000]  ? acpi_ut_delete_caches+0x56/0x7b
[    0.372000]  ? acpi_terminate+0xa/0x14
[    0.372000]  ? acpi_init+0x2af/0x34f
[    0.372000]  ? __class_create+0x4c/0x80
[    0.372000]  ? video_setup+0x7f/0x7f
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? do_one_initcall+0x4e/0x1a0
[    0.372000]  ? kernel_init_freeable+0x189/0x20a
[    0.372000]  ? rest_init+0xc0/0xc0
[    0.372000]  ? kernel_init+0xa/0x100
[    0.372000]  ? ret_from_fork+0x25/0x30
[    0.388039] kmem_cache_destroy Acpi-parse_ext: Slab cache still has obje=
cts
[    0.389063] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.390557] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
[    0.392000] Call Trace:
[    0.392000]  ? dump_stack+0x5c/0x81
[    0.392000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? acpi_os_delete_cache+0xa/0x10
[    0.392000]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.392000]  ? acpi_terminate+0xa/0x14
[    0.392000]  ? acpi_init+0x2af/0x34f
[    0.392000]  ? __class_create+0x4c/0x80
[    0.392000]  ? video_setup+0x7f/0x7f
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? do_one_initcall+0x4e/0x1a0
[    0.392000]  ? kernel_init_freeable+0x189/0x20a
[    0.392000]  ? rest_init+0xc0/0xc0
[    0.392000]  ? kernel_init+0xa/0x100
[    0.392000]  ? ret_from_fork+0x25/0x30

When early abort is occurred due to invalid ACPI information, Linux kernel
terminates ACPI by calling acpi_terminate() function. The function calls
acpi_ut_delete_caches() function to delete local caches (acpi_gbl_namespace_
cache, state_cache, operand_cache, ps_node_cache, ps_node_ext_cache).

But the deletion codes in acpi_ut_delete_caches() function only delete
slab caches using kmem_cache_destroy() function, therefore the cache
objects should be flushed before acpi_ut_delete_caches() function.

"Acpi-Parse" cache and "Acpi-ParseExt" cache are used in an AML parse
function, acpi_ps_parse_loop(). The function should complete all ops
using acpi_ps_complete_final_op() when an error occurs due to invalid
AML codes.
However, the current implementation of acpi_ps_complete_final_op() does not
complete all ops when it meets some errors and this cause cache leak.

This cache leak has a security threat because an old kernel (<=3D 4.9) shows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

To fix ACPI cache leak for enhancing security, I made a patch to complete a=
ll
ops unconditionally for acpi_ps_complete_final_op() function.

I hope that this patch improves the security of Linux kernel.

Thank you.

Link: https://github.com/acpica/acpica/commit/8829e70e
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/acpi/acpica/psobject.c | 52 ++++++++++------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 54471083ba54..0bce1baaa62b 100644
=2D-- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -636,7 +636,8 @@ acpi_status
 acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  union acpi_parse_object *op, acpi_status status)
 {
=2D	acpi_status status2;
+	acpi_status return_status =3D status;
+	u8 ascending =3D TRUE;
=20
 	ACPI_FUNCTION_TRACE_PTR(ps_complete_final_op, walk_state);
=20
@@ -650,7 +651,7 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_=
state,
 			  op));
 	do {
 		if (op) {
=2D			if (walk_state->ascending_callback !=3D NULL) {
+			if (ascending && walk_state->ascending_callback !=3D NULL) {
 				walk_state->op =3D op;
 				walk_state->op_info =3D
 				    acpi_ps_get_opcode_info(op->common.
@@ -672,49 +673,26 @@ acpi_ps_complete_final_op(struct acpi_walk_state *wal=
k_state,
 				}
=20
 				if (status =3D=3D AE_CTRL_TERMINATE) {
=2D					status =3D AE_OK;
=2D
=2D					/* Clean up */
=2D					do {
=2D						if (op) {
=2D							status2 =3D
=2D							    acpi_ps_complete_this_op
=2D							    (walk_state, op);
=2D							if (ACPI_FAILURE
=2D							    (status2)) {
=2D								return_ACPI_STATUS
=2D								    (status2);
=2D							}
=2D						}
=2D
=2D						acpi_ps_pop_scope(&
=2D								  (walk_state->
=2D								   parser_state),
=2D								  &op,
=2D								  &walk_state->
=2D								  arg_types,
=2D								  &walk_state->
=2D								  arg_count);
=2D
=2D					} while (op);
=2D
=2D					return_ACPI_STATUS(status);
+					ascending =3D FALSE;
+					return_status =3D AE_CTRL_TERMINATE;
 				}
=20
 				else if (ACPI_FAILURE(status)) {
=20
 					/* First error is most important */
=20
=2D					(void)
=2D					    acpi_ps_complete_this_op(walk_state,
=2D								     op);
=2D					return_ACPI_STATUS(status);
+					ascending =3D FALSE;
+					return_status =3D status;
 				}
 			}
=20
=2D			status2 =3D acpi_ps_complete_this_op(walk_state, op);
=2D			if (ACPI_FAILURE(status2)) {
=2D				return_ACPI_STATUS(status2);
+			status =3D acpi_ps_complete_this_op(walk_state, op);
+			if (ACPI_FAILURE(status)) {
+				ascending =3D FALSE;
+				if (ACPI_SUCCESS(return_status) ||
+				    return_status =3D=3D AE_CTRL_TERMINATE) {
+					return_status =3D status;
+				}
 			}
 		}
=20
@@ -724,5 +702,5 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_=
state,
=20
 	} while (op);
=20
=2D	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(return_status);
 }
=2D-=20
2.43.0





