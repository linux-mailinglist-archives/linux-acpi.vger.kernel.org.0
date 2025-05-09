Return-Path: <linux-acpi+bounces-13667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF8AB1F23
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 23:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159F6A07DA1
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28A25F967;
	Fri,  9 May 2025 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="rQFCly7o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BA2609EB;
	Fri,  9 May 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826740; cv=none; b=EqKRE9MS3sCYt3pfwjGTF9GGOByE/gZUBlQi5qVJlO+bAEVHY4Ci1sSdxqRcYAXRkT0VSNPbYBBPakstRdfExbGKmRsZpinAiKnOAWRjOer4bIg1SaPL4ruR/E4KVLE+WPa95Y/VYHEK8R3IIm9vms+WpZwrHH/Uv7I2IG9klwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826740; c=relaxed/simple;
	bh=Asc0Up5ZKgwcmRN9Oak/nj2zL5A20LLaT+qVCQk+8rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfSShCVa/Zp2eWavZ5dcYUSpZj1/8VlIz5cOd0ZbT3dVS3V3m5fZROSPJcERUhuf5bLn6ARcYJ+ekwGOe6HExvK4H47DkJi7DZ9ypyskjVhC082GRcbghkPbMGALu4O6KuoAemfZMvtCJSbfwxT0F297HZ+3jvq1fahLuL+hnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=rQFCly7o; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.27] (pd9e59308.dip0.t-ipconnect.de [217.229.147.8])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id A9B512FC0052;
	Fri,  9 May 2025 23:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1746826734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5ltLD/6kQgNgYKcZFivhTH/Sq58kWeiIH+3zDPgGvI=;
	b=rQFCly7o/m2VnE5eXS3vTOCVyytAXvcYElxQ8rD/Aevf97ae64yX/ezWWmq9uDUNldxgAF
	euv/Fn9Cz8ZBRkYmo8qh2zP8ZzsfLP6K/mCtm5cqNdvjyo2OTNl2kqDOgQiQ/E1n3yCP7w
	xdaUy7ZDkm8lskup2PjtyC6XVibnKPg=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <421e737a-bb7c-4d80-bead-407e756bba68@tuxedocomputers.com>
Date: Fri, 9 May 2025 23:38:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/ec: Add device to acpi_ec_no_wakeup qurik
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250508111625.12149-1-wse@tuxedocomputers.com>
 <CAJZ5v0g+_8LT6YKSuOXHtxE-HLCZ2hxKuT2514HgQ45xyWy76A@mail.gmail.com>
 <994476b8-fdc8-4123-ab39-de8f1629c27b@tuxedocomputers.com>
 <CAJZ5v0hSvd1RhZRx9iZs=zNaiUcxEhz+41285iecMBRjeHV0tw@mail.gmail.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <CAJZ5v0hSvd1RhZRx9iZs=zNaiUcxEhz+41285iecMBRjeHV0tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 09.05.25 um 22:23 schrieb Rafael J. Wysocki:
> On Fri, May 9, 2025 at 9:49 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>>
>> Am 09.05.25 um 21:21 schrieb Rafael J. Wysocki:
>>> On Thu, May 8, 2025 at 1:16 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>>>> Add the TUXEDO InfinityBook Pro AMD Gen9 to the acpi_ec_no_wakeup quirk
>>>> list to prevent spurious wakeups.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> ---
>>>>    drivers/acpi/ec.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>>> index 8db09d81918fb..de45a5b59effd 100644
>>>> --- a/drivers/acpi/ec.c
>>>> +++ b/drivers/acpi/ec.c
>>>> @@ -2301,6 +2301,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
>>>>                           DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
>>>>                   },
>>>>           },
>>>> +       {
>>>> +               // TUXEDO InfinityBook Pro AMD Gen9
>>>> +               .matches = {
>>>> +                       DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
>>>> +               },
>>>> +       },
>>>>           { },
>>>>    };
>>>>
>>>> --
>>> Applied as 6.16 material, thanks!
>> Forgot to add cc stable but i guess i will just wait till it reaches mainline
>> and then send it manually?
> I can add a "stable" tag to it, but it won't apply to older kernels
> anyway because the table has grown recently.
>
> It's better to send manually when it gets merged I think.
ok

