Return-Path: <linux-acpi+bounces-6514-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A792890E254
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 06:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290A4281E8D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 04:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E02208A0;
	Wed, 19 Jun 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="BsV/oZYn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5331D6A8
	for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718771614; cv=none; b=mlOqAKRVh+ykh31xwRUyK1Q63ri1CEPPcGkOzbltaMTTXBDekXvnwVPU6ZZZQIK1ZL9F1fHfv3XtFZ6g91kYpo3yu2Ycs27Lkox3opgfbv5RPYJHNa84PuH5lJz1x/stTRWcM/RmNcH6JxtuBK0tyENsRQUhW5w5Kx/sbeTXMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718771614; c=relaxed/simple;
	bh=l4w/LvYlB6QlwrMz9fQ/LSeC2pWpySat/4xzansMIl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLZTbG8GF1XLqgvR195Bb2STZ3W3fhooUY+o6iIF7UTnG43y1QGReYa7EJxQIJpENdeSC91JEuv/7qQe0hg8JSGe5CcmHLUrqgiFhwolUJsD4k+4lo+bS981XiYuVp9A4ooeF+NRA3UMim5FRPeWOgwJVeuSgfrLL/BpIG9poz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=BsV/oZYn; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7e23dc4bda0so245210839f.3
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 21:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718771612; x=1719376412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWlYdNwXcIt2Uj/WmtGcgNX4cntxb9XSir9I0MKekec=;
        b=BsV/oZYnjcRwcKgN0jA396kw6i3pE1roVC4RTq/qrsBzXvdjLYJ1bBRCAfYFrMsOLF
         sDy33TnfqAMea6eZqGNitJ1mOabovwVsaRUGFXlY0mATrLp/qzbgPxHxZai9jxZCkgft
         4G3/170cG+OpvLJJbsBXErZRPnsZudRbup448NlNXEz3BMkRE/mo58LAn2caM1i996XP
         3ZwGrnTkBFcK7NmgB1/83NwfnPMyiSzY6rGND5zv6CJ9NavBSkT8cbsTLg26ECl3bmzs
         suLOTERpcsNb2+749LakndoZrQZfx72zD9IriizX7OTeqgB2s+m6ibkQXc2rRt6uqx2Q
         74cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718771612; x=1719376412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWlYdNwXcIt2Uj/WmtGcgNX4cntxb9XSir9I0MKekec=;
        b=h8pFL4D4e104OmpkEvinP+Ujru1uks/+uV91F1nd9wflxnafN3hgyKbKUZNzk6Fbbq
         D3Nx/BYrEDYjI6dy2ka2eqWQoYWf0RfbdmuVu1ySqo8poCkddfaTRqfUFptkcYj3b0cu
         d3rl7iM6l2xivZRSR9Zqh1ODU6w5WtI8sHTZNF5kInWTdOBWis8ygMmBL2zQ1K6LzcV7
         UjK4jQqVP1VlD21O2p00QKAs/CD9hGP8jWwCLoVNA8uAeDKJlr4OnTdlYL0/fdqQgr3j
         y9PXs3wVPAHIWvvT8evLwJZP4o2XmpKesQMBy85SNdU1RhgT68Cj1gse42FvLvrMXiOg
         1Yuw==
X-Forwarded-Encrypted: i=1; AJvYcCXYOGV7GGUMAZWqmOERHhgw4z169rQJTwPTgZasbPnYSbkVf44jZF1VEaahCyaVCx3gOlSmZTFNoLjkkTrCmhZ2p0agpdpYm9bG3A==
X-Gm-Message-State: AOJu0Yz16aePZtAAmUxHVMfP/huY/NQgt9rHYiMYNIIX44gJFxymD0FH
	4BtiojyuB5vmX7NOKONn25zPWHvaSHiHhkFXm1RaBm7b2G+HHhww3yj8LvaQpGI=
X-Google-Smtp-Source: AGHT+IERVC8ibZcD8y1uku57YmVlXRCDnAChTM5lB2gA4zuk557SjUwxDXw/tQhWcQEXPUrzPE/adg==
X-Received: by 2002:a05:6602:6c10:b0:7eb:7f2e:5b3a with SMTP id ca18e2360f4ac-7f13edb2453mr214966539f.2.1718771612308;
        Tue, 18 Jun 2024 21:33:32 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9a1d0980fsm691665173.102.2024.06.18.21.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 21:33:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 23:33:29 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnJfmUXmU_tsb9pV@kf-XE>
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
 <ZnHtPbszYT8afOOk@kf-XE>
 <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com>
 <ZnIAX9P5XSco4cZw@kf-XE>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnIAX9P5XSco4cZw@kf-XE>

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

Tested-by: Michael Mikowski <mmikowski@kfocus.org>
Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>

---

V2 -> V3: Move bit ignore to before switch.
V1 -> V2: Rewrite to work in cpc_supported_by_cpu.

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..af2d8973ba3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2063,6 +2063,12 @@
                        could change it dynamically, usually by
                        /sys/module/printk/parameters/ignore_loglevel.

+       ignore_osc_cppc_bit
+                       Assume CPPC is present and ignore the CPPC v2 bit from
+                       the ACPI _OSC method. This is useful for working
+                       around buggy firmware where CPPC is supported, but
+                       _OSC incorrectly reports it as being absent.
+
        ignore_rlimit_data
                        Ignore RLIMIT_DATA setting for data mappings,
                        print warning at first misuse.  Can be changed via
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index ff8f25faca3d..0ca1eac826af 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -11,8 +11,20 @@

 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */

+static bool ignore_osc_cppc_bit;
+static int __init parse_ignore_osc_cppc_bit(char *arg)
+{
+       ignore_osc_cppc_bit = true;
+       return 0;
+}
+early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
+
 bool cpc_supported_by_cpu(void)
 {
+       if (ignore_osc_cppc_bit) {
+               return true;
+       }
+
        switch (boot_cpu_data.x86_vendor) {
        case X86_VENDOR_AMD:
        case X86_VENDOR_HYGON:

