Return-Path: <linux-acpi+bounces-9620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A149D0571
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 20:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB542820D5
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94D1DAC9A;
	Sun, 17 Nov 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qa+Abd/e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984631C1F02;
	Sun, 17 Nov 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731871389; cv=none; b=OOtNId+uWDMM0QR0wJFvL0feWOJGnMhNeENGQ3T48RcJyHzdLNODna5b3HOgNtaG1R0TlVsPN+003O7ejS17vJYbZ4it6Wp9opbR3aApuJAAQgWuV4H3w+9hTslPirbv7KVf+IZNq5ZoxYoKFBGyLQ2/yZ4j27wJDQkcY5ag9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731871389; c=relaxed/simple;
	bh=qvvcw2rGSvVYr54LWhSwv3Jj9H1IvuduUO0bJhYedc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ekj3voef4JZYEQYIjTB8C/C2G+KsFcqArj+RBtbv4LCNcZCDSg8lKzY6RCafr9gt11fPvrx1irhJWnkITOVinCVmnPhauo+dg+nqVy01Hzuvh1seKhAolRrHlblRCjh0uUlAfiYg1wTktEPF5Lw3EW/2hTRG6xdEe1Ehr7OZau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qa+Abd/e; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731871320; x=1732476120; i=w_armin@gmx.de;
	bh=LpRR3FeRRmpTYUZWtc4tjgOoBSbvw3ZG88sGvtb5rwQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qa+Abd/e9tTTYdvhS05twHeyLe5Kc0/vS7akznmd7J2VxWdh6UyfTQJhx9XzR7UO
	 ji0LDCfObVhPS7vbd2k5zYnKKDHwHy8HcbiN7H8b8UgfyKtiIk1qseJRxdKOVbNEm
	 0zPI83pwP5/AkUwsBWow3KGWsDxVRb5Yfounv1089IMJl5MFdt2fU9Tc/AhVVEMdo
	 yF/skV+V2o18qObMEuZUOhB+gp0/cmRMJx/snHGFg+AAetSMeCwh1ZSsU9QbZdQVL
	 5pyZP7S87OfP+LXDzEQqnxrTCH7SyNG6G0KgwVQgJ+YM7GGzCfMASxxZlYD55J/VX
	 ecUiEcKfCnuWdhW7xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1tE8QH0uk1-003ImY; Sun, 17
 Nov 2024 20:22:00 +0100
Message-ID: <c5df06b5-b827-4978-a3fd-63a0fa052f87@gmx.de>
Date: Sun, 17 Nov 2024 20:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/22] ACPI: platform_profile: Notify change events on
 register and unregister
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
 <20241109044151.29804-15-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241109044151.29804-15-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IECImMn+Qr7qI4SmFfOcZ8DpysDVqkGClF3OMSnb3x7UAV90VVB
 ddCbtnELaUOlnIxl4ZEK5DLQ3vWqoh0P4TnrJ7nqbsUqRbBDdeoJ378pd4Zs2X7SUW6G0SP
 ce/mZJTDAa2dMiKTzXCX1VOkWxUTOT06JcWEsZDKiOt5wn2XKOL3pF2GNyihLcRGbZZBXJ0
 sIwWBTMyfl0CEDCy4DUyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IItYEDh3QUg=;YsuqOR8Y7+L66qpcV0xHMXjWizj
 sjHp0ooV6Iq+PhcqudO5nZFMVPQqP/C3EXG9saQk8fmXnWa+I/bcAUGcUx52JTFlYflgIq5pz
 sTEz1KNDl4bFFsXwHAOLvyJigynz32WU6yYH7AbG2D1C9196I8VixjfuIM8ubXTMMltu6X5Lm
 irzfIqBWTWmIXagBEuU5Ljt9yV2SrcEa7STJsFhm9oous9ujx/TVP8b8DyiXqTXJJr4xQqgz1
 aMDtrrHcnGwYlDH01PWhdeA4zMhhJEQuXjXVuz2nhc/9gmpqaFivG6n9WZpYQxp0/Xwoin7Ya
 ZCA/g4OGsY4Jn0LfibRVbobBUYoLmnwBCE6N0zJcFbiIMgSAMXAOrc3q7SWxq0d5LCfOEvi4K
 Z6YteQ93eoIrU2+dIzOn7vGW2nV2W3F4D7eKQ2qsCe0WeUZfxhB2dqcwaB1C690UNdbOQz+l5
 qP0nZg7s9lw+mA6OVvK0N2q0wmsAuTh56mLL6/Ti9l+9HG3m3BiQ8ql/Q27s2yk7sLx7doJLz
 12ecEIzxpJgUMKGBWrTIFNDpgz4yHdBtKQak2deSJaR36q+QoVU6QnyM8eqKzTPUf5lQqokbm
 140knkoCsCdp6DB3JNxfcrmTRyTD62khqv+UgMoutdpCir/gKP1GAVM3nxbMWL7zW3vFHbjn9
 /+4YLof2wkqjYo/0SpV87nYWkIvoL+/eKA9yJH9cbAq4qKP7nVQhLQ1EiC8f9/27JfnrDGMOO
 /FUM32TP/mdDuTOgV/b8R575H51V38KJF7g4vAouD1C/8qK8OEBZKmXbUv7OTnmS2rwhQipfz
 tuMhXlsx1bVdEDgxR/gS1M5SLHkLfAaPbytmBVsFY51Jj8vIwRR3txABGX978/fpt6Ud5r7Vj
 k/ypZcQxOKmBuei8PLEPuqWsctW3skCFmQlrnDoTs18kbLZBw8efhlRO7

Am 09.11.24 um 05:41 schrieb Mario Limonciello:

> As multiple platform profile handlers may come and go, send a notificati=
on
> to userspace each time that a platform profile handler is registered or
> unregistered.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index c5487d3928c1b..c4d451782ff18 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -380,6 +380,8 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>   		goto cleanup_ida;
>   	}
>
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
>   	cur_profile =3D pprof;
>
>   	err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
> @@ -408,6 +410,8 @@ int platform_profile_remove(struct platform_profile_=
handler *pprof)
>   	device_unregister(pprof->class_dev);
>   	ida_free(&platform_profile_ida, id);
>
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
>   	cur_profile =3D NULL;
>
>   	sysfs_update_group(acpi_kobj, &platform_profile_group);

