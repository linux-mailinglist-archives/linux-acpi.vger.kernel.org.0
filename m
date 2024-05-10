Return-Path: <linux-acpi+bounces-5742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D63F8C2888
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3372A286A47
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1E172790;
	Fri, 10 May 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="e5I/E8M9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A93171E6A;
	Fri, 10 May 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357458; cv=none; b=Tw4LvjV9d1za4J3EXSt0EWk99HD9AI35NNYm54FrXXvi6WVcZK/BzF/kafq8W2BMZZpqWvYUTLRqmzRQmJ+Jd0xK2dO3xk/zdrYcvHVGlRtcN4Ofhyvp0Fbtu+ovU16vtdbrGA2ZnZk+RARse2UjZbr9lkp+Ed2SLQnuL/yQLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357458; c=relaxed/simple;
	bh=vIb63Tg9ODhQyImpTi/p/It9EzWF4hC3W4ffMtiZYOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf5MbdukQH7Y7TDASAC37knLe72gkzlbWUTWWM5BOXr5VS6xZE/p32fnQDgaWn6JOX8g4Pni2rGvzI465zkM+MvPyBoWKS087leFZjTQoYe3V5YQ7p8dBw/uDk8U0ny9FdGEJeq8Xjwtl9/ANPP3GjvIYAc9ZPwp08WpI/x8HFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=e5I/E8M9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715357443; x=1715962243; i=w_armin@gmx.de;
	bh=xr1Ot3xxQfSAEra0ddoF6dHCjwQwKZTlryFWw7m/NIw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=e5I/E8M97ujDrGuoRzcE1uYI1tMBXWaxpZW/QF7sf9dmS/1XyuWYFptOq+RzcyeA
	 qZ6/+NU8OPM4d+SNBOJsYXRVxZORMmF3kxAahLTqtQrgplk1M87e7YagkjIlpCwTa
	 RtjGu2secTOdpZZ6S1ymkY3noPAOmrzVDP0yNsKEedjFOdaaA6gA+n8wg71xd8VX9
	 YC67GaMDd12vIQo0XEMyH7qLNxiMhz+q1Ag95ueYahXI0V6QVvmZRt8jaoYscaFap
	 vZvaHRhE1/EYvEYLaByvhtoMNoAMBk+/c3Y5N2o6wQE4iQLFvEw/4RBKEOD7Ly++t
	 0ggnz005491jJeY0/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1rwyO21lYn-0094wz; Fri, 10
 May 2024 18:10:43 +0200
Message-ID: <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
Date: Fri, 10 May 2024 18:10:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4926735.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wT+tLSg2LVm+YP/FL5UN8kpyCaKCGFIvyGUPP/xh/wPnOaDV56r
 yYx/2FRPk8cGNlfVqBgjCf0IqqambicmHIL3lWGOQ5G3gCMKj6stPvWIzeEb9caTmxixewX
 m5weDTBex+msUw8JO9vU7W1pSq8SrJwArJSWnhedn3iJqQ///NUduLr68spl6hZF0gOaHIh
 YSK+t6W0r6y0xMdM9VsZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B1Q9O29DO6k=;5JAa00wiMzS+9jZ5sBBfJXlIKvS
 ippXqs6y/q0bvs2T9xaBYAlJAayYnQUTHOxf4D/mOoSbtZAttUsXoyb0orxwYosAgL7QQ4cPR
 q3Ag/WlGGeNH/vsYQ9gTB/XRIvQ7m2WEr59Wa06UrLR2JN8vvn9Wm50oQgW96ViV1L/rL7rtq
 xFqZyi9evjXCkVRmn7inaS3W8/J7TseuOp606rnjJxf3ECWH3Q9McW4na3q6/a6Gtv9x3ovWG
 omSNmbe+gjyPxuLOo4iRpaMJN6JbawpCXGeE1xQ+ISJJibbZxvVM0ztfPLzXgOJyR/dUkCRYQ
 06d7/QqSS1H37NIeUH9LMkWo4WCMFCLT0vMdGdFwTqa/MUTj7uHIkZIua/1NNSf2o00UoAml8
 e5oUSBVNmSuWjWWL+vUMOgF6TDd4erprYxMqd0fIZEn+dYTUyYPx+j0WruUwvZYlueWJrco8h
 QsBVSex3BchnTMurJbpBNokazNs71bRhpCXKArW7TppKsvB1Q8yrcHjsBtC+M727w04Esuwml
 yL8ZsANJZuA1vLMRybJ/pDYdUFduehFwDogFP2joaDUii+B+i3VSXR280xUOhVNvgvfcv8tCH
 Tm0V7TIo5ZG+tT+TSmn7hAJqjHXSiJNOJJW7aWi2ba4z4xNbmfS89ZZHR3nDbuT+glBmqkx7z
 uv5UEK7sswUo7ugVDP1oYit7jWZm+xRCbjn3c9gcyi07MIfU6frDbr8lP9EOABF8Vn3+IuPDl
 olBBlEGD63e1H6JApPH+xs7tVE+YCJ+87vluubpDae11bNaqhlpt9j71wABOF7mkbdGAZqLvz
 YAkoUv+fdn8evLRs6bHAQ2Gl6r94JcOjjJnRpWKhiag3o=

Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
> IdeaPad Pro 5 due to a missing address space handler for the EC address
> space:
>
>   ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedC=
ontrol] (20230628/evregion-130)
>
> This happens because the EC driver only registers the EC address space
> handler for operation regions defined in the EC device scope of the
> ACPI namespace while the operation region being accessed by the _DSM
> in question is located beyond that scope.
>
> To address this, modify the ACPI EC driver to install the EC address
> space handler at the root of the ACPI namespace.
>
> Note that this change is consistent with some examples in the ACPI
> specification in which EC operation regions located outside the EC
> device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> so the current behavior of the EC driver is arguably questionable.

Hi,

the patch itself looks good to me, but i wonder what happens if multiple
ACPI EC devices are present. How would we handle such a situation?

Thanks,
Armin Wolf

> Reported-by: webcaptcha <webcapcha@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218789
> Link: https://uefi.org/specs/ACPI/6.5/09_ACPI_Defined_Devices_and_Device=
_Specific_Objects.html#example-asl-code
> Link: https://lore.kernel.org/linux-acpi/Zi+0whTvDbAdveHq@kuha.fi.intel.=
com
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/ec.c       |   10 +++++-----
>   drivers/acpi/internal.h |    1 -
>   2 files changed, 5 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/acpi/ec.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct ac
>
>   	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>   		acpi_ec_enter_noirq(ec);
> -		status =3D acpi_install_address_space_handler_no_reg(ec->handle,
> +		status =3D acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJECT=
,
>   								   ACPI_ADR_SPACE_EC,
>   								   &acpi_ec_space_handler,
>   								   NULL, ec);
> @@ -1497,11 +1497,10 @@ static int ec_install_handlers(struct ac
>   			return -ENODEV;
>   		}
>   		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> -		ec->address_space_handler_holder =3D ec->handle;
>   	}
>
>   	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
> -		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
> +		acpi_execute_reg_methods(ACPI_ROOT_OBJECT, ACPI_ADR_SPACE_EC);
>   		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>   	}
>
> @@ -1555,8 +1554,9 @@ static void ec_remove_handlers(struct ac
>   {
>   	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>   		if (ACPI_FAILURE(acpi_remove_address_space_handler(
> -					ec->address_space_handler_holder,
> -					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
> +						ACPI_ROOT_OBJECT,
> +						ACPI_ADR_SPACE_EC,
> +						&acpi_ec_space_handler)))
>   			pr_err("failed to remove space handler\n");
>   		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>   	}
> Index: linux-pm/drivers/acpi/internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -186,7 +186,6 @@ enum acpi_ec_event_state {
>
>   struct acpi_ec {
>   	acpi_handle handle;
> -	acpi_handle address_space_handler_holder;
>   	int gpe;
>   	int irq;
>   	unsigned long command_addr;
>
>
>

