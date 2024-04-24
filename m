Return-Path: <linux-acpi+bounces-5328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F138B0929
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 14:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDBD1C23BF8
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Apr 2024 12:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6D15ADA8;
	Wed, 24 Apr 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eo45agJf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC841DFCE
	for <linux-acpi@vger.kernel.org>; Wed, 24 Apr 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961303; cv=none; b=GX8JA3XJeBXGVfW0wnknPpBit9HsRp8k8JVTjR0xZ3HQL4su+TYgj08FQJjVrFFQwEDs3JVaZ+8c3kQWH4y4K+V/bAebTxOuiTeHNn7MTBLrugzBE2x29SKh57AaNuVpQmqiJFEDVYWyWV2VNh3YPMSzu86EvKrrOe/eJg/O9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961303; c=relaxed/simple;
	bh=YxtpFFX7mHzwaAbOxjF4cbEoH2y8B5Deda1fqi3UAx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QynJTqi4AUqQ6WUeFiTX+lZnoSZVcH2z67BvfizFPrwVVbM9DK/5z5+gzl3Y/hukigopQyXyDcd4aNCt72Qc01ZAuneGnRt4BcBxMaSTNWpRFcLVLroFK2f3Gvh46vg8nuezMVM8Q5Qc2EjPmPgXobb1VSvC+e9wv7dbckuH7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eo45agJf; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32690d46-facf-4548-8915-d37604d2f54e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713961297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WdXEQJeti9xObmiI3NOcA4xzxVIiBqdDHBEiYkiDJE=;
	b=Eo45agJfdnNkfpNmv/kQe73FfGgL2Myav7WMwL682HSubexjghgLAS10l7CBvwCXPoCKF/
	y5B3Eb0GNXdL7fE5fLP7H0AyGsqO4lYMaVK+ZqmcRXhN5RGdiFDDMgYxucNIBNbpzmC96R
	/cnf+LaxdT7G3Sa9hrdZXlhZ2coD2k4=
Date: Wed, 24 Apr 2024 20:21:30 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
 <22979e28-ed48-467f-a5cf-82be57bcc2f7@linux.dev>
 <CAA8EJpr1vWVeGsoph9h=PPQRPKkjk+d7WVQpGwpPuhCQwkqCbg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpr1vWVeGsoph9h=PPQRPKkjk+d7WVQpGwpPuhCQwkqCbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/24 16:39, Dmitry Baryshkov wrote:
>>> Sui, if that fits your purpose,
>> That doesn't fits my purpose, please stop the recommendation, thanks.
>>
>>
>>> please make sure that with your patch
>>> (or the next iteration of it) you can get driver_data from the matched
>>> platform_device_id.
>> No, that's a another problem.
>>
>> The 'platform_get_device_id(pdev)->driver_data' you mentioned is completely
>> off the domain of fwnode API framework. You are completely deviate what we
>> are currently talking about.
>>
>> What we are talking about is something within the fwnode API framework.
>>
>> You can hack the device_get_match_data() function to call platform_get_device_id()
>> as a fallback code path when the fwnode subsystem couldn't return a match data to
>> you. But this is another problem.
> No. I was using this as a pointer for having non-DT driver data.

Whatever.

Whatever how does it going to be used by you, or whatever data the pointer you use to point to.
Just remember one thing, it is not relevant to my patch itself.


> As I
> wrote several paragraphs above, other subsystems use their own
> driver-specific match structures.


Fine, but on the DT systems, they mostly probed via DT.
Thus, the so-called driver-specific match structures won't be used.


> Reworking subsystems one-by-one to
> be able to use generic codepath sounds to me like a way to go.

Fine, you are encouraged to do whatever you like, you don't have to told me.


> Adding
> "compatible" property doesn't.



As I have told you several times, software node is kind of complement to ACPI, it's
definitely need to follow the style of ACPI counterpart. Software node can be secondary
node of the primary ACPI device node. With this understood, please read the implementation
of acpi_of_match_device() before express objection. Or you can read several relevant commit
such as 4222f38ca3b7a ('ACPI / bus: Do not traverse through non-existed device table')
for knowing some extra background.

Beside, users of the software node backend itself can do whatever they like.
The value of the "compatible" property is *just* string, programmers
are free to name their string property in their driver. It is not you to say no though.

No offensive here, I means that both of us are not good at this domain. Especially me,
but at the very least, I'm willing to listen to what expects in ACPI/swnode domain say.
One day, you become the top maintainer of specific domain, and when I go to contribute
then, I will also read to you reviews message carefully.

Back to the technical itself, the "compatible" property is a standard property
of ACPI _DSD object. This is written into the ACPI Spec. The value of the "compatible"
property is just string, store it at 'platform_get_device_id(pdev)->driver_data' or in
'of_device_id->compatible' or some other places doesn't really changes much in semantic.

A device driver can be platform probed, DT probed, ACPI probed, I2C probed, SPI probed...
Take the driver of I2C slave display bridge as an example, it can platform probed, DT probed,
I2C probed, in the future, there may have programmers want to add acpi_device_id, then, it will
gain the 'ACPI probed'.

If each of them introduce a driver-specific match structure. Then, that going to introduce
very heavy maintain overhead to the maintainers, not to mention to achieve your cheap slogan:
"Unifying DT and non-DT paths via generic property / fwnode code".


-- 
Best regards,
Sui


