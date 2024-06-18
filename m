Return-Path: <linux-acpi+bounces-6505-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B50C90DD6C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 22:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3C21F248F0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12CE1741DB;
	Tue, 18 Jun 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="xC4Qi3Cz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567A1741CE
	for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742338; cv=none; b=G6SRUawaRpQldUAyZ3Ieo9cL8ZG70OPCBwgFfzsfSKqEW7RA3BuXT8VkH38K81N4PxwRzMU6wAj2nUsSXUc2ugxBsqufe+qR4gNSSeSCYTdMWfBxl2c2Ug8ReP0y6SKCqnUZne3WBbb8fBQs3ILtNoHVT7FLV5uh4kEUSKMKBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742338; c=relaxed/simple;
	bh=8oNrbsJDUFi2arQpoa8E9JtxUyxztZ4m37R7NbDLcBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XozhOitPwp+7VlnFAzYCbaDm3O7FVVhUvbj1qD0DGYmzBuwFn3o3M6D0VTwfKiDXjQw9ZTmPlL/YpV9PtT2D+yxWG/CQ+K7QDnSUDYjbylWKlqFSO1jI5C3yUPWQen6XveydDbq0xctzr1HFAPX1g56dG0fDQoUpPk3e34RW46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=xC4Qi3Cz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-376127cad54so2164495ab.3
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718742336; x=1719347136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQhc1tsGSf/rNyW7LBFRXj7br5aBpicaH2yUEpkeax4=;
        b=xC4Qi3CzN0n/65xRGX3g60MG0yennwhcCjN44Cc9S8Z0iAISaMM2KxK6CdzHjWrfS4
         HE6rpoEWf2+G7fWo+X6sLiSRiIaFpGZZ+L0j9NFeiDjfti/5zFz5HbzSA0LU2/SDWrqv
         nw2rcr73NUCv2D/Axv0mp9sOLW+5xWY9g4dBEPDUGt59E0ZW5iRGOJroEt0TW3RJovMx
         FNaYCXWhqdVL2fLjM9qR8D8cyHbiuKqAxuYMJJ3UEP6cHypzu3dbP9OoZRV2J9xcguPh
         vxOP2SZrcx9N+z0O78a7UKILJA5i4BlQxuQKNDZL0IRkumkdrvJ44zsP4K4cX7ZPTb0j
         gV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718742336; x=1719347136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQhc1tsGSf/rNyW7LBFRXj7br5aBpicaH2yUEpkeax4=;
        b=GTld5KBLBsWBCWiBPwQ4nKdRmzHpfdq41+BXd+16OoIQ9DZ+dQ2M2ZVHGV0oP5FWSk
         fMbLJAvqwspp6kggvs6FfZiN1gdiexqirR0RSBACEV/T8Ty8xAnUlFEyJBoKwt4JAubR
         WYN1e/ASnfgWUT1u6wyZaiRo9rerlVf01l2B5MmX5M2BDJRAxtrtOFpcEBHust2COc28
         yLGDOCZ8E5NVd3CHqYXHWsc7fOTCvoBMDgIwfOMHs73DXyui49yQJPN4hdvUc4PUy78m
         zbo6FEKeMInr+i9AjJWQ0L2I7Az2Q6QNVvfB4+eZoTZqyGLmiLTI9i63cyD231oWEsXV
         H/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKGpbPeyfesL1MGPwD5WhM9ZR2LTmZI7Unk2IKIAHl9sqGR0uiv0/dBe1145m+y4tWvE9+foy7szcPVAKU8jYgpm4P7WBWplQ4Tg==
X-Gm-Message-State: AOJu0Yyi5TgT9g/16036L52/zISFC6h/2nGcyKOy3/hUx2+d78PgPORs
	BTi+qhkImwSX7ndyp2+h51LA7XcbClUXWVUs6Rl/C1MfHCqgFAE6DLbk5ZdGy0wvegyGphLtEGs
	MP5bDAw==
X-Google-Smtp-Source: AGHT+IHoJT1oMZwvIoV4Bftj499G+4TSIa9T4NEJOxqAqW/MxiIzVA6CWXBDsjwnR6+dLu4QLUTFLw==
X-Received: by 2002:a05:6e02:138d:b0:375:c394:4344 with SMTP id e9e14a558f8ab-3761d7084a2mr7438245ab.21.1718742336400;
        Tue, 18 Jun 2024 13:25:36 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d8b45132sm22438025ab.73.2024.06.18.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:25:36 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:25:33 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: mario.limonciello@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH V2 RFC] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnHtPbszYT8afOOk@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>

acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter

The _OSC is supposed to contain a bit indicating whether the hardware
supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
be considered absent. This results in severe single-core performance
issues with the EEVDF scheduler on heterogenous-core Intel processors.

To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
enabled. This allows CPPC to be properly detected even if not "enabled" by
_OSC, allowing users with problematic hardware to obtain decent single-core
performance.

Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>

---

V1 -> V2: Rewrite to work in cpc_supported_by_cpu.

RFC: I have not yet tested this patch to ensure it functions properly,
 nor have I attempted to compile it against mainline. My system takes
 a couple of hours or so to build a kernel, and I'd like to submit this
 for feedback now and test once it's sent.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..af2d8973ba3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2063,6 +2063,12 @@
 			could change it dynamically, usually by
 			/sys/module/printk/parameters/ignore_loglevel.
 
+	ignore_osc_cppc_bit
+			Assume CPPC is present and ignore the CPPC v2 bit from
+			the ACPI _OSC method. This is useful for working
+			around buggy firmware where CPPC is supported, but
+			_OSC incorrectly reports it as being absent.
+
 	ignore_rlimit_data
 			Ignore RLIMIT_DATA setting for data mappings,
 			print warning at first misuse.  Can be changed via
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index ff8f25faca3d..7346a25e68ce 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -11,6 +11,14 @@
 
 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
 
+static bool ignore_osc_cppc_bit;
+static int __init parse_ignore_osc_cppc_bit(char *arg)
+{
+	ignore_osc_cppc_bit = true;
+	return 0;
+}
+early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
+
 bool cpc_supported_by_cpu(void)
 {
 	switch (boot_cpu_data.x86_vendor) {
@@ -24,6 +32,10 @@ bool cpc_supported_by_cpu(void)
 			return true;
 		return boot_cpu_has(X86_FEATURE_CPPC);
 	}
+
+	if (ignore_osc_cppc_bit) {
+		return true;
+	}
 	return false;
 }
 

