Return-Path: <linux-acpi+bounces-9693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE99D3A3F
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEDA284F43
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A51A2541;
	Wed, 20 Nov 2024 12:07:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F81A0BC4;
	Wed, 20 Nov 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104444; cv=none; b=mfF8ezS2/3sER3omPNCTeo05WEhFC1hAboAhTUAwttkkU6SevT9wArIIakhuvzaOZJIY0zqsIi8UnH0GJMpzNgAOTDPJKbMJSVnJ+T6vICzXJfjZ/u/BKE1FW+xti9zu65Bks6NfPoBzjSM/3WSJ0j+K12PT5uYv22lgAT1wwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104444; c=relaxed/simple;
	bh=+ES4eCUGerDzw7CVIREWHBrZyVPMPYd3bfM8noBD5Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PT8JiKUvmA3+hchlAQZLy2YvJbeq7P6McYOYk2br8hMNhckyKFMMAs3/cSg01bNYiLt+aXAY+OCuUtch6Xo4xZ77gR62W38vgYbvFPslJEcqEX8HnFUUvNeHxGTbI5rxqPDEwL7jUW7TKPztnuOuOg0XSQYmku7XwoY2HKCV4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C2E1480;
	Wed, 20 Nov 2024 04:07:51 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7039E3F66E;
	Wed, 20 Nov 2024 04:07:19 -0800 (PST)
Message-ID: <dbc2892f-0735-4510-9509-b225b65537c9@arm.com>
Date: Wed, 20 Nov 2024 13:06:58 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in
 acpi_os_sleep().
To: Pierre Gondois <pierre.gondois@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, anna-maria@linutronix.de,
 tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org,
 corbet@lwn.net, akpm@linux-foundation.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Todd Brandt <todd.e.brandt@intel.com>
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <60f8eac0-9144-486b-983f-4ed09101cf0a@redhat.com>
 <CAJZ5v0g7rpdUjrS969stJiqqtO5zG+FTr4TOxg+SYN2dPC_9jA@mail.gmail.com>
 <4daf0c32-9799-4eb5-8334-175d8089bc39@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <4daf0c32-9799-4eb5-8334-175d8089bc39@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/11/2024 10:01, Pierre Gondois wrote:
> 
> 
> On 11/18/24 13:02, Rafael J. Wysocki wrote:
>> Hi Hans,
>>
>> On Mon, Nov 18, 2024 at 12:38 PM Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi Rafael, Len,
>>>
>>> On 18-Nov-24 12:03 PM, Rafael J. Wysocki wrote:
>>>> On Sat, Nov 16, 2024 at 12:11 AM Len Brown <lenb@kernel.org> wrote:

[...]

> FWIW, testing the above version on an Arm Juno platform by executing
> the following method:
> 
> Method (SLEE, 1, Serialized)  {
>   Sleep(Arg0)
> }
> 
> _wo: without patch
> _w: with patch
> - Values in ns.
> - Requesting to sleep X ms
> - Tested over 10 iterations
> - HZ=250
> +------+------------+----------+------------+---------+-----------+
> |   ms |    mean_wo |   std_wo |    mean_w  |  std_w  |     ratio |
> +------+------------+----------+------------+---------+-----------+
> |    1 |    8087797 |  2079703 |    1313920 |   55066 | -83.75429 |
> |    2 |    7942471 |  2201985 |    2416064 |  111604 | -69.58044 |
> |    3 |    8373704 |   144274 |    3632537 |  111037 | -56.61970 |
> |    4 |    7946013 |  2214330 |    4606028 |  255838 | -42.03346 |
> |    5 |   11418920 |  1673914 |    5955548 |  131862 | -47.84490 |
> |    6 |   11427042 |  1677519 |    7045713 |  211439 | -38.34176 |
> |    7 |   12301242 |   221580 |    8174633 |  330050 | -33.54628 |
> |    8 |   11411606 |  1672182 |    9191048 |  431767 | -19.45877 |
> |    9 |   16722304 |  1288625 |   10517284 |  103274 | -37.10625 |
> |   10 |   16746542 |  1280385 |   11564426 |  417218 | -30.94439 |
> |   20 |   24294957 |    70703 |   22756497 |  673936 |  -6.33243 |
> |   30 |   36284782 |    74340 |   34131455 |  391473 |  -5.93452 |
> |   40 |   44703162 |  1199709 |   45407108 |  289715 |   1.57471 |
> |   50 |   56311282 |   281418 |   56098040 |  607739 |  -0.37868 |
> |   60 |   64225811 |   247587 |   64302246 |  132059 |   0.11901 |
> |   70 |   76299457 |    99853 |   76282497 |   83910 |  -0.02223 |
> |  100 |  104214393 |    38642 |  104212524 |  244424 |  -0.00179 |
> | 1000 | 1016131215 |   245725 | 1017051744 | 2748280 |   0.09059 |
> | 2000 | 2007711297 |  1325094 | 2007628922 | 1421807 |  -0.00410 |
> +------+------------+----------+------------+---------+-----------+
> - With the patch, the min sleep duration is never below the requested
>   sleep duration
> 
> So indeed the penalty of using msleep is big for small sleep durations.

Just to make sure, this is with Rafael's proposal, using msleep() for
values >= 48ms = (12 * 1000/250)ms and usleep_range() otherwise?


