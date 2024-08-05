Return-Path: <linux-acpi+bounces-7282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5233947B36
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 14:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E819B1C20FAB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791641553BD;
	Mon,  5 Aug 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlF1nE4Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721B1803A
	for <linux-acpi@vger.kernel.org>; Mon,  5 Aug 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862043; cv=none; b=E/IcOl9w/HL7BCuBtvA7urJoNL1L/p46yXHpkBN8tzkUVvugLsSWpx97LTrEdkV9M6zgNZfI7ULxjhk4CNS8rG+uOpCHg3brheZx4mjgN4beIONOxQMcty6ij9vi6aE3XJaDnJp1yp9EWAfg0Vqbv260dMYfcPk3D2PuuvkGquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862043; c=relaxed/simple;
	bh=lXorPtIcINzpzQT1+4xSp8lVpu8Nu7rmWI0qP6+cDac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MHTvMitYjM22d4joZ0Tb49PzAw1OT3p1niOXGrmoaghHNniKtUoc0Et6wI/lSrXBS52zbyn13bWQDcQfZ5ASsVMaApRTthijL9iOFyb2nI5OCY0HF4nUjuDiFmOYd+DlK9H4te94Fx44xcCNOurC08manRBcwMREYBws/DrFdl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlF1nE4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722862040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5QBGKMUdgjidJH4ld0lEwnUBEgXu18HSivQJy7T4lc=;
	b=DlF1nE4QLRF9N5xyPHZiK1A30++xvqrOPUrJ0EBenwFFvBV2Lf+3l0Ntb4r2Too0Q/RpgT
	Eub9W1qRDk7gimAqXQko64WYDj/SY6PTe6BafTBVzTZd36s44hVJGzCA209Ojc5zzUfha3
	MiJY6/bs82tGNVk5dM08abM3gUmmKoc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97--enVM-wuPl2JqwVinAizlA-1; Mon, 05 Aug 2024 08:47:18 -0400
X-MC-Unique: -enVM-wuPl2JqwVinAizlA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7a822ee907so958484066b.1
        for <linux-acpi@vger.kernel.org>; Mon, 05 Aug 2024 05:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862037; x=1723466837;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5QBGKMUdgjidJH4ld0lEwnUBEgXu18HSivQJy7T4lc=;
        b=E/XWzFMCCudbX3xsSEyayYLi7o1U4K+DGy0iv3PDAGKo7/3PbRA7I+Gq5/BnVB310G
         lbvlRyWNf6icZiS55bgYd1fD8qznTlAp11ald0H+LS7KhzCKCFxh02SLkwq5F8e+e1VA
         rU6bh+HxwuLUKmN+PU3stOfHNbZt4PNkrHvl8Zp8WBIn05pm6Z5nUTtJ/9WYKlOqKslu
         u4/UyNpmjo5rM7mMMUfGxnmia6e2rjYDmGTPwc78BeDyyL7fHH86U2bqeLktzzeDldDX
         hopn1uWsbn1E16QMlxKMT20aWkQsL78y+zNFLCX04V28n/G8KvIP+elpDWBBc+aomNYo
         88vg==
X-Gm-Message-State: AOJu0YxSL5/CRkD3A58YfD+UOXb7oEBXbx9VZgnIOFXdcd0cXVIqhGYz
	RwaHnkgcGH4wKFYNNAYDoKtpnzOSgh7LGbfBl9x9yVHESx0/cxaokhlnR7gsb13AKdvisVDCqib
	MuYeMoeQuBy895ylNCjRLhKqejszGHrdZNzub8Oixmt3NwiEMUshl283drtgjcoynONs=
X-Received: by 2002:a17:907:6d17:b0:a7d:2498:f927 with SMTP id a640c23a62f3a-a7dc50a49efmr902282666b.44.1722862037014;
        Mon, 05 Aug 2024 05:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1125wgdPyNh6RjoTJs9uHsfZpDSxBcAKOpEYlsK5T+Cm6dfnVivLpLbr8V1ZVdDwY9OrhAg==
X-Received: by 2002:a17:907:6d17:b0:a7d:2498:f927 with SMTP id a640c23a62f3a-a7dc50a49efmr902279966b.44.1722862036435;
        Mon, 05 Aug 2024 05:47:16 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcc86asm448108166b.28.2024.08.05.05.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 05:47:16 -0700 (PDT)
Message-ID: <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
Date: Mon, 5 Aug 2024 14:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
 <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
Content-Language: en-US
In-Reply-To: <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/5/24 1:28 PM, Hans de Goede wrote:
> Hi,
> 
> On 8/1/24 4:28 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 7/29/24 1:15 PM, Hans de Goede wrote:
>>> Hi Rafael,
>>>
>>> There are 2 bug reports:
>>>
>>> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
>>> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
>>
>> I have filed:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2302253
>>
>> to track this now and an acpidump of the troublesome LG laptop
>> is attached there. I have also requested dmesg output of
>> a non working kernel to be attached there.
>>
>> As a reminder this is the bug where it has been confirmed that
>> reverting "EC: Install address space handler at the namespace root"
>> helps, with the caveat that there is a Thunderbolt related IRQ
>> storm on the ACPI event IRQ after the revert ...
>  
> Ok, so the bugzilla now has 2 different dmesg outputs:
> 
> 1. 6.9.6, this kernel works without problems
> 
> 2. 6.9.12 with the following patch you suggested on top:
> 
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
>  	 * At this point, the GPE is not fully initialized, so do not to
>  	 * handle the events.
>  	 */
> -	ret = acpi_ec_setup(ec, NULL, true);
> +	ret = acpi_ec_setup(ec, NULL, false);
>  	if (ret) {
>  		acpi_ec_free(ec);
>  		return;
> 
> Unfortunately this does not help. dmesg shows some EC _REG errors, which
> are now (with the above diff applied) shown just before the
> "Boot DSDT EC initialization complete" message, which shows that _REG now
> runs from acpi_ec_add() rather then before:
> 
> [    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.FN00._OFF], AE_NOT_FOUND (20230628/psargs-330)
> [    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
> [    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG due to previous error (AE_NOT_FOUND) (20230628/psparse-52
> [    1.007639] ACPI: EC: interrupt unblocked
> [    1.007640] ACPI: EC: event unblocked
> [    1.007675] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    1.007676] ACPI: EC: GPE=0x6e
> [    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initialization complete
> [    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transactions and events
> 
> Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, where as the actual
> EC (and the only acpi_device on which _REG would get called for the EC Opregion before) is:
> \_SB_.PC00.LPCB.LGEC.
> 
> Looking at the DSDT it seems that the H_EC is not used and is leftover from a copy/paste
> from some reference design DSDT. Its _REG however does write to the EC before hitting the error
> and I think that that write may be causing the issue...
> 
> The H_EC device does have an _STA method and looking closer the troublesome EREG method is
> also called from _INI. So I guess that _STA is returning 0 causing _INI to not run and
> that is the reason why we are not seeing the same EREG errors with kernel 6.9.6 where _REG is
> only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for the entire ACPI device
> hierarchy as is done with >= 6.9.7 .
> 
> Maybe we should only call _REG for the EC opregion on present devices (and devices without
> a _STA)?
> 
> Also note that both LGEC and H_EC use the same cmd + data ports.
> 
> I'll go and ask the reporter to retrieve the status of both LGEC and H_EC and then see
> from there.

The reporter has confirmed that of the 2 EC devices ( H_EC / LGEC ) only LGEC returns
a _STA of non 0:

> Here it is, with kernel 6.9.6:
> 
> $ cat /sys/bus/acpi/devices/PNP0C09\:00/path
> \_SB_.PC00.LPCB.H_EC
> $ cat /sys/bus/acpi/devices/PNP0C09\:00/status
> 0
> $ cat /sys/bus/acpi/devices/PNP0C09\:01/path
> \_SB_.PC00.LPCB.LGEC
> $ cat /sys/bus/acpi/devices/PNP0C09\:01/status
> 15

And taking a second look at the other bug:
https://bugzilla.redhat.com/show_bug.cgi?id=2298938

That one also has 2 EC ACPI devices and the errors come from calling _REG on the one
which is not picked as the boot_ec :

jul 19 17:33:41 kernel: ACPI: EC: EC started
jul 19 17:33:41 kernel: ACPI: EC: interrupt blocked
jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC.ECMD due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FNCL due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FN00._OFF due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_EC._REG due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
jul 19 17:33:41 kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
jul 19 17:33:41 kernel: ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions

Note the H_EC vs EC0_ in the errors vs the "Boot DSDT EC used to
handle transactions" message.

So the issue in both cases seems to be calling _REG on an unused EC acpi_device.
Not sure how to best fix this though ...

Regards,

Hans




