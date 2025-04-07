Return-Path: <linux-acpi+bounces-12776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156F4A7DF21
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673A03ABA0F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2CC253F05;
	Mon,  7 Apr 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="Y0tXSlgk";
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="Y0tXSlgk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EB28F6E;
	Mon,  7 Apr 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032323; cv=none; b=kqw8yKp0PDLmQNrYfpaHirKsfGIdov83i4nl8NQQ1phYGdgPtPxo+i/2ew8OvtgxCyzCye6wo3FPym7OHEMKsgYAvtcNKEZ39rozougt9xo2b8omXkRMWCvMRvBDscGaYVuj4qmAxCdUfp48VKJwWR3ufIG1CKnQU4LoV6YqAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032323; c=relaxed/simple;
	bh=jgqlR/RZXRnBn7wdj7Cpp/D/3y/l34/oVH7lZ/6BnIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dz03bVgJJncA2B53ryHJAiQOootFDikdIW+9IyTX2n291cnOEV/C3AUBRid+qvinia8LNxpD41iQCXhImtXlm/CbsZV88p4YvXcD0x1GXD6n1kK5p78N6Pd1aUJLhJWpp+kkyrSPVUQNr5C2vOKiu+CsNRfcizZeZJAFQ2O/MeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=Y0tXSlgk; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=Y0tXSlgk; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-1.centrum.cz (envoy-stl.cent [10.32.56.18])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id EC1DA2078CDF;
	Mon,  7 Apr 2025 15:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1744032307; bh=M/srLozqjowrKwxtWCSUenY0UgmwFAtRY3NtZmGhjoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0tXSlgkErRtODYBiUMGYNczgBWjKYFksC5143OmPUFkyQ0py/iJvocinpd0MJ7DR
	 n0BuqzTbY/xeYcSWAURax2xclTD7SGgGJQLwWjG8Xc+nC3y7QqnxagS59kOe4GT+Hi
	 xKLbtottagnJ/BxrCuTMYiu/tBzEFZwaJmMnImIA=
Received: from gmmr-1.centrum.cz (localhost [127.0.0.1])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id E8F7F1A6;
	Mon,  7 Apr 2025 15:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1744032307; bh=M/srLozqjowrKwxtWCSUenY0UgmwFAtRY3NtZmGhjoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0tXSlgkErRtODYBiUMGYNczgBWjKYFksC5143OmPUFkyQ0py/iJvocinpd0MJ7DR
	 n0BuqzTbY/xeYcSWAURax2xclTD7SGgGJQLwWjG8Xc+nC3y7QqnxagS59kOe4GT+Hi
	 xKLbtottagnJ/BxrCuTMYiu/tBzEFZwaJmMnImIA=
Received: from antispam30.centrum.cz (antispam30.cent [10.30.208.30])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id E5FA219E;
	Mon,  7 Apr 2025 15:25:07 +0200 (CEST)
X-CSE-ConnectionGUID: JocpOiqgRoW7s7bex2I8zA==
X-CSE-MsgGUID: pHnCKEnUQlCmrY9o+Cl+1Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EDAADz0PNn/0vj/y5aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFACYE3AwEBAQEBCwGDM4FxhFWRcmGLGIYzi2qBcwsPA?=
 =?us-ascii?q?QEBAQEBAQEBCS4WBAEBPwaEOAoCiyonNQgOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?Q0BAQYBAQEBAQEGBgECgR2FNVOCYgGEAAIBAwEiDwFGEBgBDAImAgInLwYTg?=
 =?us-ascii?q?wKCMAEDMa0qgTIaAmXccAJJBVVkgSmBGi4BiE8BhHxwhHdCgg2BFYE7gT5vh?=
 =?us-ascii?q?BoBhAOCaQSDR4RTkgWKHUiBBRwDWSwBVRMNCgsHBYFsAzUMCy4VMkQ4HYF8g?=
 =?us-ascii?q?3KFOIIRggSJFYRaLU+Dbx1AAwsYDUgRLDcUGwY9AW4Hll+EDQcBWTR7dniQS?=
 =?us-ascii?q?7YLhCWETZUEh3caM5dSHgOSZJh+pEuEaIFoAYIUMyIwgyJSGY48FhbMAXY8A?=
 =?us-ascii?q?gcBCgEBAwmCO40tATOBSwEB?=
IronPort-PHdr: A9a23:BaswThdmsij45968CuU390jxlGM+7djLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASTG92DoKgc07CG+4nbGkU+or+5+EgYd5JNUxJXwe43pCcHROOjNwjQAcWuURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi7oxvdutMKjYd+Jao91AfFrmdWd+lV2GhlOU+dkxHg68i/+5Ju7z5esO87+c5aVqX6caU4T
 bhGAzkjLms4+s7luwTdQAWW/ncSXX0YnRVRDwXb4x/0Q4/9vSTmuOVz3imaJtD2QqsvWTu+9
 adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTnRdUMlPSyNBA5u8b
 4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlVjXH0wKI6yfwsHwHY0gE+AtwAvnfaotL3O6ccX
 u+60KbGwC7fb/5Vwzrx9JLFfgwjrPyKQLl+cdDRyU4qFw7dlFuft5DlPymI3esCqWeb6fRlV
 eGygGMgsQ5xuDuvyd0piobTnIIY0UrL9Tl9wIkvPt20UlJ0YN+9HZZWqiqVOJd4TNk4TGF0p
 CY11KcGuZijcSQX1JgqyB7RZ+GDfoaI/x/uSOafLzh3iX9meb+yiBm//0ijx+DiWce501RHo
 yREn9TMuX0Byh/e58qGR/dg/Uqs3yuE2QPL6uxcLk05lLDXJ4Ahz7MwjJYfr1rPEy3slEj0j
 KKablso9vWm5uj9fLnquIOQO5VqhgzxLqgigMiyDOU+PwMTRWaU4/6826fm/UDhRbVKieA5n
 bfBvZDBIMQbura5AwhI0oY/8xq/Dymp0NAfnXQfI1JFfQuLj5PsO1HSOPD0EOqzj06wnzh1w
 fDGIqfhAojILnTZjLjgfK5x609ayAUt0dBS/51ZB7AbLP7tWkL8tMbUAgEnPwG22erqCtVw2
 psbWW2VA6+ZNK3SsUWP5uIqO+SDfpUVuDXnJPgg/fHul2Q0lkUBfamtx5QXc2q0EehnIkmBe
 3rjns8BEXsWvgo5VOHlkkeCUT1JaHa3Ra08/Co2B5i6DYfHXI+tm6aN0zu6H5FOfGBJFkiME
 Wv0d4WDQ/oDciSSLdJ7kjMaW7mtUZMu1RaptA/i1bVnNOTZ9zYEupLiyNh1/ezTlB4o+TNoC
 MSd1nmBT3tokWMQWz82wKd/rFRyy1qA0KV1mP9YGsJJ5/NPTAg6MYTQz+tgC9D9Qg7BZMuGS
 E66QtW6BjE8Vs4xw9AKY0dyANiiihHD3yy3A78JjbyLA5o08qPT3nTrOsly1W7K1LM9gFk+X
 stPKWqmi7Zw9gfNAY7FiliWmLi0dasC2C7A72ODzWuVvEFESw58S6rEUm4ZZkvOt9T54UHCQ
 KGyBrQ7KAdBztSCKqRSZt3zkVpGXOvjOMjZY2+pmWewCgyIxrSXbIrxYGgdxzjdCFManAwJ4
 XmGMg0+Cj+7o23CFDxuCU7vY0T0/Ol6qXO7SFI0zg6TY0J7y7W14h8ViOeCS/McwL0Eoj0tq
 zZqE1an2dLZFd6AqxBmfKVGbtMx+E1H2n7BtwxhIpygKLhvhlofcwRxokPv2Ax7CoZensgwq
 nMl0g5yJLmG0FNOaTyYx4r8Or7JJWno+hCgdarW1kvZ0NaM9adcoMg//mnjuwSgDQIN93hmw
 99YyTPI+prOHCIWUJTsTlww8Rlq4b3XNHoT/YTRgEVhLbP8jDbEeNFhUOI/yR+lds13Ob+AH
 RS0GN9MVJvmE/Ajh1X8NkFMB+tV7qNhepr+L5O7
IronPort-Data: A9a23:ws5s2qz7AqqBuXO7cth6t+fKxyrEfRIJ4+MujC+fZmUNrF6WrkVWz
 2YcUD+PPf2JZzTyKtF+aoywo0pVusOEyNRnSgNu+FhgHilAwSbn6XV1DatS0we6dJCroJdPt
 p1GAjX4BJlpCCKa/1H1b+WJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYx6TSCK13L4
 I6aT/H3Ygf/hmYoaj1Mt8pvlTs21BjMkGJF1rABTa8T1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+ZZk
 4wR6MPqGW/FCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 d4fIygqbwmMveWJn6nkQOR83OVzPuC+aevzulk4pd3YJfkjBIvGX72TvJlT0TEsnN1LW/3MD
 yYbQWYxKk6dPlsVYAhRV89WcOSA3xETdxVRslGcoKMty2HPyAVqlrP/WDbQUofTH5QJwRbF+
 woq+UzhIhcxF/GZ9AOB2Xe2t77I3gj/G9srQejQGvlCxQf7KnYoIBQMVlK+qOORg1K6UskZI
 F580iMoobI/6wqgSd7lUgfjiHWFogQdS5xbFOhSwBHdlILX7hyfC2xCSSROAPQ6u8smbTgr0
 EKVhdTvBCwpvLD9YWKQ8PKYoC2/PQARLHQefmkUQA0d+d7hrYovyBXVQb5LEqGvicbuMSrt2
 D3Mpy87750XjMgWx+Cy9kjGqyyjq4KPTQMv4AjTGGW/4WtRYI+jepzt6lXB6/tEBJiWQ0PHv
 3UencWaqucUAvmljzCESuEANK+m6uzDMzDGh1NrWZ47+FyQF2WLId4WumwjYh0zbYBbJFcFf
 XPuhO+Y37cLVFPCUEO9S9/Z5xgCpUQ4KenYaw==
IronPort-HdrOrdr: A9a23:wZCehaMFyYxuqsBcTsyjsMiBIKoaSvp037Dk7SxMoHtuA6ulfq
 GV7ZAmPHDP5gr5NEtLpTnEAtjifZq+z+8R3WByB9aftWDd0QPCEGgh1/qB/9SKIULDH4BmuJ
 uIC5IfNOHN
X-Talos-CUID: 9a23:d87GiGz6gwMWXhBoyF7GBgU2Hcs9VXzEw03XHBCjVmxkWOe0GU25rfY=
X-Talos-MUID: 9a23:Vt6T6wajnKiKdeBTrx/qrxJPMvpR54+rEnFcltYtv4rdDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,194,1739833200"; 
   d="scan'208";a="312947855"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam30.centrum.cz with ESMTP; 07 Apr 2025 15:25:07 +0200
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id F2BC0100AE2A3;
	Mon,  7 Apr 2025 15:25:06 +0200 (CEST)
From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	arkamar@atlas.cz,
	Juergen Gross <jgross@suse.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/1] x86/acpi: Don't limit CPUs to 1 for Xen PV guests due to disabled ACPI
Date: Mon,  7 Apr 2025 15:24:27 +0200
Message-ID: <20250407132445.6732-2-arkamar@atlas.cz>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407132445.6732-1-arkamar@atlas.cz>
References: <87ecy5wqjm.ffs@tglx>
 <20250407132445.6732-1-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Xen disables ACPI for PV guests in DomU, which causes acpi_mps_check()
to return 1 when CONFIG_X86_MPPARSE is not set. As a result, APIC is
disabled and the guest is later limited to a single vCPU, despite being
configured with more.

This regression was introduced in version 6.9 in commit 7c0edad3643f
("x86/cpu/topology: Rework possible CPU management"), which added an
early check that limits CPUs to 1 if apic_is_disabled.

This patch updates acpi_mps_check() logic to return 0 early when running
as a Xen PV guest in DomU, preventing APIC from being disabled in this
specific case and restoring correct multi-vCPU behaviour.

Fixes: 7c0edad3643f ("x86/cpu/topology: Rework possible CPU management")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org # 6.9+
Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
---
 arch/x86/kernel/acpi/boot.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index dae6a73be40e..9fa321a95eb3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -23,6 +23,8 @@
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
 
+#include <xen/xen.h>
+
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
@@ -1729,6 +1731,15 @@ int __init acpi_mps_check(void)
 {
 #if defined(CONFIG_X86_LOCAL_APIC) && !defined(CONFIG_X86_MPPARSE)
 /* mptable code is not built-in*/
+
+	/*
+	 * Xen disables ACPI in PV DomU guests but it still emulates APIC and
+	 * supports SMP. Returning early here ensures that APIC is not disabled
+	 * unnecessarily and the guest is not limited to a single vCPU.
+	 */
+	if (xen_pv_domain() && !xen_initial_domain())
+		return 0;
+
 	if (acpi_disabled || acpi_noirq) {
 		pr_warn("MPS support code is not built-in, using acpi=off or acpi=noirq or pci=noacpi may have problem\n");
 		return 1;
-- 
2.48.1


