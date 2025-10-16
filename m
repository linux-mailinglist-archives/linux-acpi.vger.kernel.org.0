Return-Path: <linux-acpi+bounces-17845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73425BE5AA7
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 00:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 527404F3162
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 22:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE22E2296;
	Thu, 16 Oct 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oZTMVaCH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04F2E03E1
	for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653383; cv=none; b=cCpGSBxcBbAENy9YnOsFECUzDsuHQw+cLRBLRpAvUnDaLPWQxDCT8MUd8bffIFGf6IiPiGFahPRWIQEJLNCxTq7xb4oOXy7GPSFT07Dx9NXTlYCKpjNzY4TKtIe+lI7eF/EHn7tpmFXRTAuwycfPtAqUECu//8A3GetTS76gmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653383; c=relaxed/simple;
	bh=3ekii4Padoo4vLo5RlCV8aomTzPPeL5/QviVnlsRBu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeSR/vsjuFyLEoBe91+emheN9bJC8mQmnkzJcL0igKQNwBrOES+WVCiAQ5MXyj/Pa+QSV5HWnggCYYgqQXL1wZip2drC7EWPXstC+RT5fbN5nd35NF9sUP/udPbHIRvFur4FIgyFvdUT+k9jLb/jzVqwc+lSCWQU1AbLvDATriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oZTMVaCH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290b48e09a7so12562195ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2025 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760653381; x=1761258181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkSN+UnBTkzCG3PwDHFkCHOX5m2YbVVWNnREzEnFMow=;
        b=oZTMVaCHq/k0tx3yiSzxJBt/n2F6POmsgUBNRgGUTwpbiuSjPYj0kDam07TY+m9U1L
         3MOyijOH4WZe/MFS6ZMdRJbgZ9pX4h/vohe9K3EB9mUKAc9c5AKQmyBLTZy0nxNWshmt
         Oar3glofJ7e3eRxfjDE/kFEE9TktjK/o8F9JJzLbcCl8/bU8aN/ANIpP7rfWRnwqu0Or
         2w4Jh8p/GU86eBKLffTZBWRSzl37PrhU5/9rd24zpjrInpFupQ2/2hZbH/bHYnSkaEpG
         x5EaBspLDoq+pvMxV+6X9Z2qcJNSiHJPo98+lzgQHl8oYyI1XUn4Uh2k82tM6HXOHlpG
         wJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653381; x=1761258181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkSN+UnBTkzCG3PwDHFkCHOX5m2YbVVWNnREzEnFMow=;
        b=L/7YjQ8/qQmpULDSu3WKpf1MXFLxP+HeImoON05n4IzebQAPwdBOmNAF9uvQ6Fe1yg
         KZowfRgOHAzDDSa9BGQADmMG3ZQ3cjjEVDfOXIPPeQtFxXMh1h8HPQnBo24kC0vIW/AW
         daCHTWum6TpHkGTQZRkGOiIVf6ILipHheCUhTT1X9Fy0LWsTH3I+v9Dx83ZGHlYptY0q
         TQpiZeOKt/wOnjmw3A5k/Thu8oYbZh5PRorYbQMjBzDbjNfM2fQB3znoeDmkXUwSenJC
         hQ7aDx8sma90MtHr1Vi1iEmSoOi+FXOotXa3oNY1khKqc9jqMqFrrUTaDnVEH/oW+MTw
         GnLA==
X-Forwarded-Encrypted: i=1; AJvYcCWuKSX8toyDYTK2JD/HofDxex7UxHiLVgp6vnZCy6/gWUuO+TqDvTSSDZ4jiCxG993jvraZ/OpxWaZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YxmATcMhWA4dPywYxjXs1Silx56tYbLvsULV/5hk4w/25hdx8bh
	KXSZp2q9b4ncFhRs4dkIJuotfCSfQWHTO37B+62KZNAonzOzbDewTO0Qpa91UPUnOao=
X-Gm-Gg: ASbGnctmivl/M3+JH3YFksue7vKb/bHyYJdJDoJY+V1jEVmgjH9ldSJNlnT5FSCMLFQ
	8VnB+e4CTs2jNA5kRGfqkmwfZ3iHfSn7o+D1rvhj7mLhKdUWGfcakARltEtINl585gqo8gVwMCu
	Ik7OmnLBpliaXlKVkF6W7nREteLoomUpwpiHMU7E4g7lJzcQMa0Bk1D18dSXeTBl0L2zKmY4sWE
	BOL11yMu7ZKytjw1sBpDCZsArmiwABALgOy2bIlNF/rTOpIE7FqJ/NnBqjrUlBqM9TdEbN2S+bk
	/Ay/60jVHAJ/yaP2xPOW0IuE8sajk88G7PPpv6ZG998ctuUZCbRHWMrbzaGA8nGak+Y3UEEk8vY
	gM+Sl2ASCg+eB+YSKNnjEDks8YocM3+ywCZZy3HnyFBQ59O67MlJrQCyIBTpE++XF6usuPU6XxE
	40JE7u2A==
X-Google-Smtp-Source: AGHT+IG6Ed2MBjmz0upGafcO94uC04MsCaD920R4+63rtx35D385DHJTV6ADNuxL5fUjZODV+u2KRA==
X-Received: by 2002:a17:902:ea01:b0:267:d2f9:2327 with SMTP id d9443c01a7336-290c9cf2d88mr20529015ad.27.1760653380873;
        Thu, 16 Oct 2025 15:23:00 -0700 (PDT)
Received: from sunil-laptop ([106.51.195.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934b0b5sm41627735ad.38.2025.10.16.15.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 15:23:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 03:52:53 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: rafael@kernel.org, regressions@lists.linux.dev, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	apatel@ventanamicro.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Daniele Cleri <DanieleCleri@aaeon.eu>
Subject: Re: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in
 ACPI
Message-ID: <aPFwPR2A0CN6k1Vl@sunil-laptop>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>

On Thu, Oct 16, 2025 at 02:47:40PM +0200, Thomas Richard wrote:
> Hello,
> 
> While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
> noticed a regression. The driver does not probe anymore and I get the
> following error:
> 
> [    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
> initialize FPGA common GPIOs
> [    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
> failed with error -2
> 
> The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].
> 
> I did a bisect and I found the commit which introduced the regression:
> e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
> to support nargs_prop")
> 
Hi Thomas,

Could you please try with below change and see if it resolves the issue?

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1b997a5497e7..43d5e457814e 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
                                       size_t num_args,
                                       struct fwnode_reference_args *args)
 {
-       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
+       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
 }

Thanks,
Sunil

