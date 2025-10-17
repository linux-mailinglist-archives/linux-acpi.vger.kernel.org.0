Return-Path: <linux-acpi+bounces-17859-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BD9BE7484
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 10:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B24188224C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5762D47ED;
	Fri, 17 Oct 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dV32Q4aY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA22BDC13
	for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691016; cv=none; b=eg1MtXLmSFIeHnlSUnFOkOk5JUX042fHT3RC6tR1EFhmyQ0dX/oh1I+KPHvM0Q63NCtz5yIXe2cv4HGEe8QPw0t7wvI+Nlbsr5TAaSrd37ORZ1W25fo9ntnlEZieBY2yQlGcT7nHBFUO2BzEFcPKATt6EOl84H0oUHfR0PMhajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691016; c=relaxed/simple;
	bh=s1Yo82IJv4nrT4EzmA6HcScsGLMa+FQA2rYZSctawl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cu2BDoieRYTeqAwhY/+FCVfDOJstHq1K8zTN15sn7PdRUG+YGnsbiuJrv13RLE5JfXqY3+g2Y/HCjcvE2i6G8iAW+e24wnKO/Knu/eGzVpbGYCAhIyFrLpcxJ8pN+xbbvr6bOp4+y/rtkUL6Jz54H+bZ3fp28V3G15qYN606QVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dV32Q4aY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AA2C71A146C;
	Fri, 17 Oct 2025 08:50:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76AD3606DB;
	Fri, 17 Oct 2025 08:50:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95D3A102F233E;
	Fri, 17 Oct 2025 10:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760691009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=43pG8BQLKj+x3xmj3cNlrBF7tFn/hLhmRKzHB/XG16o=;
	b=dV32Q4aYnMf7iwy92cdrKVRoRlNzzYyDMW8PGFHNKguzEYPlmdJ4wxctojfIzdG/3HSggI
	SSIuEA8H2QRtIwZqkJSyHCF0z4ziL4gJmftYdkUZTJb9LcOBKy+PUK8keG5FDPxLN6LkC1
	933cQ1f2+ZxbsTwR+iek6cIGQkxlfa4V0ja7IYMe/uzcMfvCWyfutl2bReCpNd7nx2OoNo
	PZ7RVCB6bSs9JwX6LSf/7RVW+qvg31R5S+CyVE5fQQqpt4gxpQ557bDKNdysakHT5clII0
	51mHTxh1OqIBr6XBziRyGw6yrMOOvWt85XaE4TKl1CqqusrxTjGbC2iAGoPsAQ==
Message-ID: <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>
Date: Fri, 17 Oct 2025 10:50:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in
 ACPI
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, regressions@lists.linux.dev, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 apatel@ventanamicro.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Daniele Cleri <DanieleCleri@aaeon.eu>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
 <aPFwPR2A0CN6k1Vl@sunil-laptop>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <aPFwPR2A0CN6k1Vl@sunil-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/17/25 12:22 AM, Sunil V L wrote:
> On Thu, Oct 16, 2025 at 02:47:40PM +0200, Thomas Richard wrote:
>> Hello,
>>
>> While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
>> noticed a regression. The driver does not probe anymore and I get the
>> following error:
>>
>> [    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
>> initialize FPGA common GPIOs
>> [    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
>> failed with error -2
>>
>> The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].
>>
>> I did a bisect and I found the commit which introduced the regression:
>> e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
>> to support nargs_prop")
>>
> Hi Thomas,
> 
> Could you please try with below change and see if it resolves the issue?
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 1b997a5497e7..43d5e457814e 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>                                        size_t num_args,
>                                        struct fwnode_reference_args *args)
>  {
> -       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
> +       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
>  }
> 

Hi Sunil,

Yes your change fixes the issue !!

Thanks,

Thomas


