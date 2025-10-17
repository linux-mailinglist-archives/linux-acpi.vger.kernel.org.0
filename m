Return-Path: <linux-acpi+bounces-17862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F1BE7ED8
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 12:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B611A612F4
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047BC2DEA99;
	Fri, 17 Oct 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lqDzQu+g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647172D595F
	for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695355; cv=none; b=M8JW4bUtMBDcLo9heDu7zW/zz8KLCb6uJMCA7jIrff5Lc+Fvd+HCNMEYHOgAHzM5iJIezKNOgowALlprHIrlHYZ6qETrHUO6uIFZkJ40yLhQON/qyAQl+Ll5YepyJOCC4SSdeY/g2IdnvuahgykHWcvycqH4fjrkuANjFfKm8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695355; c=relaxed/simple;
	bh=drZrnQKEAi0sMCaCh3X6bSQOyyKvMOxESRxUPZpCKWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/AnFK0ZckZRbkqQOTnrgYbGHbrAkykFrVBbwPSe+e/9CGHglWzeFwgjseni0yiCIdoyMuE4jVzXftiJvKl+Q5ZWyOL2U+c7EjGsuVeJEc7yKJTIsirVF4dvu2HtHtxghQMOx92FvlfIBZlVBkqjsoR0Ez1qP6MDA/2B45I6Y3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lqDzQu+g; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-793021f348fso1693410b3a.1
        for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760695354; x=1761300154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7OtZ/yQXFhjzdgsw+HJSVcKTN14IDqdEkJg8GvBN38=;
        b=lqDzQu+gI1tXgG2Z2HtEWr7i3Dwp512iw2ApjgppGcwvvOmvZHjrLsNBqPu8WKddAd
         kFDUIsxKgOTdnNyK7XniFjTbTw3lp3cfdNeGV/m9AswJN2ngGWJdcDYeK+/aMe1lxxRZ
         mo9ISeRAzlkH8y4USd/oDHEBJ/14jo8xZtsqJWa32Q5SyrsVkX5KW67FQqmV4gX5fEth
         VewOMNLITed5xQ20lkxxXCihymPl0wjHT8wWzyJOIjtfG2JM5eg6AQGRXyqJtwlZtdoy
         OgZj4iRFiKYIPv5oYKfsGS7jkUtV2cgroT6Fk2t1eTEvdFu21+lJnjOe1fTroQe4OLWg
         mZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695354; x=1761300154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7OtZ/yQXFhjzdgsw+HJSVcKTN14IDqdEkJg8GvBN38=;
        b=Il32PAoScRjvKSAPkYxfsr9OL952GIfaeeFQ3mr6tXG45dR6wWuHDEl5oAEwx1ozEr
         2n1H2lG36J9/ebTz7kpTUC3337RCLnSp1l/EQpXPhPEhlswQ3vgaLe8f6TySfsCiISs9
         pKyc0UYRkjDwuTF/TFlrRPAMZu1qMQSkjTn+EUKYMYNgCoKtvQ3dqRm8Nh+DgZ+dlkX+
         OPdjYIVD0cysOWPDIAc7REg0LoS8Gck1ekoFywbgDxGrvzRaeV2J5HDZz1LQggJL8zFJ
         +2tLkXO6QiigL9Fxq2dROcb0UqkoAWqp8MTIfi7ccoWNAj487MulQqeo+1MHm+P4Sp08
         u0CA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ch5laP96L5d1RyBKIIG/joxUR+q/UBcOOvkOxJImGKZCt18RwcYMSMjHNveKoOgCiugfw2vLBHe5@vger.kernel.org
X-Gm-Message-State: AOJu0YyO87tC5esoPPWALQXLBDwAh84PGh/+FonYHP/7Wn0W4KdGvFYb
	sCPKS9U5NYhTc84lPI3eWp58r283pKBLKePEQPyAhC5fQJbW7Yl9vVoJLaD0eSrIq6M=
X-Gm-Gg: ASbGnctEsuFnMxeELvRnm71zEKD/4esNDfLU3T4/DE5h4rgOeExCdI+PbWDzVz2gkzD
	UlnsS0gGg0QCpWys2+dp6bbiJEqLhVDZ4Mfqyk9O5ahWyg1LjSm7VSq3hKY08YimgJzwu+j2hS9
	n4XTvbHuUzkDv3sHpUrRofbPPcZFeJ0ghlsUqxaSKKFEqMJESyw+qzh/tjJwm2oBXXo9j42ErR2
	cUADOhGnB/s1hgAAjc7nU+m2ORxmoAbhVZm669o3oeQqgAxBT3AH33zh8b1upar7wTRRrE3Lovr
	3G0UOzmnXES+7vYWi0Dt7sh9Ae61Hg1P7dvnw7d3CNPIRmCBFZbxV+Q2SkwVGn/w6y2o22AAu2/
	5KQ/olMwCPk7/wzKI7h6F57YpEtcIXf5tI22VXpZbGohScQPHtxCsdL92HNi0yPxYsfRg42EonV
	qGeaf9l7LKMJGjy1gc
X-Google-Smtp-Source: AGHT+IE+kO+0ih3otr2ilVER5YmhgcFdSR2CzWc/DSxY990pGJYLOQdsIKv6VYHabOMyYhFDg7EDug==
X-Received: by 2002:a05:6a21:329f:b0:2ea:12b9:2dfa with SMTP id adf61e73a8af0-334a861fea6mr4543402637.40.1760695353736;
        Fri, 17 Oct 2025 03:02:33 -0700 (PDT)
Received: from sunil-laptop ([106.51.195.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b3173asm2358675a91.12.2025.10.17.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:02:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:32:26 +0530
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
Message-ID: <aPIUMoDxW-yl2nPm@sunil-laptop>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
 <aPFwPR2A0CN6k1Vl@sunil-laptop>
 <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>

On Fri, Oct 17, 2025 at 10:50:05AM +0200, Thomas Richard wrote:
> On 10/17/25 12:22 AM, Sunil V L wrote:
> > On Thu, Oct 16, 2025 at 02:47:40PM +0200, Thomas Richard wrote:
> >> Hello,
> >>
> >> While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
> >> noticed a regression. The driver does not probe anymore and I get the
> >> following error:
> >>
> >> [    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
> >> initialize FPGA common GPIOs
> >> [    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
> >> failed with error -2
> >>
> >> The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].
> >>
> >> I did a bisect and I found the commit which introduced the regression:
> >> e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
> >> to support nargs_prop")
> >>
> > Hi Thomas,
> > 
> > Could you please try with below change and see if it resolves the issue?
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 1b997a5497e7..43d5e457814e 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >                                        size_t num_args,
> >                                        struct fwnode_reference_args *args)
> >  {
> > -       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
> > +       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
> >  }
> > 
> 
> Hi Sunil,
> 
> Yes your change fixes the issue !!
> 
Hi Thomas,

Thanks for confirming the fix!

I'll send out the patch shortly and include your Tested-by tag.

Apologies for the earlier issue, and thank you for your help.

Best regards,
Sunil

