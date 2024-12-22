Return-Path: <linux-acpi+bounces-10273-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B49FA86D
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 23:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7257165484
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2A1953A1;
	Sun, 22 Dec 2024 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Pqeim2Ty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A7125D6;
	Sun, 22 Dec 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734905873; cv=none; b=MsrEDTv4EPJtdQpAEWW3s4Mf6vSyQJoEgxtV3pjmztI6AB9jdNfbBl45zE4Ma+gU3stJZcqqcKPd6ZWdZXisovfgy8H9y4ngZ8RC0sSSnX3Rpo1hPXj8qBLFRheW6Ml2ZWT1Q4s/9NRfq55wL5r7eG0WCYDyZnmAqBH5N4asFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734905873; c=relaxed/simple;
	bh=xk0OeOj/Bd22pemQYjv6v032hfPHVlGrak3XXXboCSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPJtXv7uiIzFh8iMO9VPmrRoD4cNjisspYsTZbmBeb9mEqfCCtBl8+oB9Gp5R09UWNOL22Qg5iZxms0n6XV8bKHM3Nk5xeDKTR4m51P3T7bk1Sd1DL7OJKmV/0Xf2tHCxY0l7hdIk0Wl+OMIgaArVAVs1lma3qPY8WE3A1MZ0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Pqeim2Ty; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734905823; x=1735510623; i=w_armin@gmx.de;
	bh=ZUAaKgbFnF6n99KJfszCoYnUUvkbHdNVl9xCmHO5OJY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Pqeim2Tyh1Cm77hES/ct076ZAzdMyqYIZWlriCP4CAWNbzRBYePWjrhUWAfdmcLO
	 iv2SRJ/9i9a77oHRk1tR/BXgSDSzknGY176cHEujwY6e64myJeQxJ+jxFneqZMv1j
	 juJL+Ms4AtkoMWir9bB60NbfbOZoNeIpT5flkdPyqqzYzMzybiSomEnsHvM8BrWOI
	 rOGA+c6ImHRYFG3B8tR7NO519/1Slm+khbA2PvU3rntwp95gBKusCVFOjydzgIa+A
	 k+E5i9qdnjzR6u300H7qcudnmqTY8s/8VxaZeEPlL6UaSrHDOpquvUvQ0kKQa+MF/
	 Umb0Epuea9d2wr85sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1tuCNT0yeG-00qlv1; Sun, 22
 Dec 2024 23:17:03 +0100
Message-ID: <a5d402aa-274a-4748-81d9-1c98e90798ad@gmx.de>
Date: Sun, 22 Dec 2024 23:17:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Device managed platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241221070817.3764-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241221070817.3764-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1QTXkC9Izs26znY7V+EyJrKunkOTUcYB3r2VY8l7f7HcZ1jBY0f
 m4QsH/V0QA4+5uo8fdiDkj1b86K4bri27H3cH9nfi9yHOL5Yn+jLIeLS07AOGs/AJGCjbh2
 r5Ctn76GekerHMG9e4x/RU7TC9Kar4QVUnFyy+JDT5fKSHggZlSfe2V95qzYZn5i7JyEYNU
 Xki3lBw0NDXGEqvouz2BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LwoJnbYA3SM=;evuU83WbhxJzhaICqWe1MAZb7Ml
 K8xT7YleCLu6bUOotvvTQrTMStYhBxbY2icD4GIe0Gq2lh9TFvvuprL6EDWImzNuAWYdWxYIf
 aTgA3b7i1VbIE2ota1RbyVd69o7pEhCxskA50vHtmxrjvyjEb8rZQvIm3IJRcRsoHbv678j3j
 KljsTn1GvwlrXqB1cgWaz4aPcDPgKBHiygt9N0QAIo0J9XWvfed6geT1dlw7Ds8HcyGvPH+XI
 TPtWQlJfOvH6gwqAFg+1Eoedog792Q8M7zjHsiUdAKZ4pmUENswZt16rnjUngY+XgQT8GMLIt
 yDKNEQONGQ5BnDITfQtWHxF4h891JZfHIhIAI1ZQvyIMf3ryL3Iz0LuLx0Co8vp++qOzQY4uB
 dffwIcxCvcFnoz22bAzJ/g9Rh1TwLE6iajkd+eKspKB2wnVkVlNpryeWwJpCjWRkSiMBgJwCY
 2Y3NmCK6pb3QCveiT7bRlJP6pAJjBa+k0pMjlMIljxc4pIl521pWU48TT6rRYeEfRu5rY8gEC
 9rQ8kDmVsMIiOeaVJlyQ7AWvs2tgVLBwBPbO2qXcEVyJpXh9p3TYxZWx92yuSCowHvnMS+oPX
 aQv94YuS99CCvBc5VMr1iKXSuqsAHzguECbagZ7W376GGVLH8IWwew44dMJ/n8W1+KbUa1MTc
 2njf5Wv8AJ3TLHgUKbzJ2thP5wIpAfB/fU8dzQ03Po8y/AxIlm5U7ZANnfR99604UeC5WawXN
 ky39nczPuMVKrnmHBjtjQddob94EEOgV+2iMW+q3/0wn9xYrxbkR0unKYICM+8HXeUqj77buC
 BlU6xQPkQSbSvhiM7mPZca/XW+nUm8xOZlJXXj9nZnDeAcVcNvnDD9v/3kOKn+3ZmM6GGexhw
 oc6EJA8gK61xvnbkYCmvsxqraDd8MmYFNGsB3dq8Xaydz9VJwuh2JdBSMvveqb6A+1JerPnJO
 ffDtKVsMFwfiMXIgSwbZyD/bG7osycSjXBoDtKHNxq+bX3crdEX1LefDoUd1o4WTZsnCYHDCh
 dlLQKLB+HT9wzRbEWJDxQtZAHvMWVio7G8jpmlxwSpti4W9Eeq9F0Zg206D+UGpjTY3j3sVup
 gClTohSlkRa6VzonmLKalwPK+n3JN2

Am 21.12.24 um 08:08 schrieb Kurt Borja:

> Hi :)
>
> Now that the platform profile is tied to a device, this would be a nice
> thing to have. Let me know what you think!

Hi,

i like this patch series, having a devres version of platform_profile_register()
will be very helpful in simplifying the error handling of such drivers.

> I can also replace existing users of platform_profile_register() where
> it makes sense, if that's ok.

Sure. However keep in mind that this is entirely optional :).

Thanks,
Armin Wolf

>
> This is meant to be merged on the pdx86 tree.
>
> ~ Kurt
>
> Kurt Borja (2):
>    ACPI: platform_profile: Add devm_platform_profile_register()
>    alienware-wmi: Use devm_platform_profile_register()
>
>   drivers/acpi/platform_profile.c           | 27 +++++++++++++++++++++++
>   drivers/platform/x86/dell/alienware-wmi.c | 10 +--------
>   include/linux/platform_profile.h          |  2 +-
>   3 files changed, 29 insertions(+), 10 deletions(-)
>
>
> base-commit: 9e0894d07072e50b83ef077ce91e504bdb7484a3

