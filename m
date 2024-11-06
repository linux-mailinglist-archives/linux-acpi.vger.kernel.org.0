Return-Path: <linux-acpi+bounces-9364-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBC9BF667
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0CFB23E2D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AD209692;
	Wed,  6 Nov 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ShGNyb7s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC5208969;
	Wed,  6 Nov 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920944; cv=none; b=KRUqif3IKh9tKwU269ruwcKfEfHuwvzx82fH3RBWYSVYxAeLkq8paJtH3r1swQPn4ymEf4XP6RX6sYPINuTjue4rF5C7nj8noWSPD/zKdWPoYh3mMude2Axlgwh7UhfCzRhC/Ee6ydh73aHW6323rpb+9pe6+jOHfmygURAurDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920944; c=relaxed/simple;
	bh=9vIkHvL9hvPktrSrM7rscVqb2ZA58R17Y2dDoLfJ8iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DApUW9xVjNPLbH1nlC7AzR6WMcVwlZBphZRkQhfDG8ObgPEN/RyhEVzwL5OYGsc92minIped+eF3OdwoHonXaCSOU9DWvMiOI7s5iiX/wpLcghTd7hwKeicM0oJRJTIQr2LoE3z/b1av8K6mqjks3z9FwkJIu18IRvZYMQQUPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ShGNyb7s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730920863; x=1731525663; i=w_armin@gmx.de;
	bh=zXO7NkBpscdEohIxAJweDFsLIyuWAvv3I0tUqol0ZNQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ShGNyb7s/+IBYAqV7MICSL1POctENXv7MvPJCKzflusSnkyRL5k/dVDErs2Cec5v
	 yQ4BOWOICCvVg2FFPBNRBHTVSInN1ByrW9EjFl3vl9FqiDwFf6S2WJl5W3NJBJmFi
	 6c7s1kyjtNrwY7MaO/edr1XIfQnPbLZxYevA9qSXzvUAVjOF3Py2lms+6yQYpzIzu
	 e/UDjhzOpuHA46Wlt9M9mR0MxF7g0v+ABhkqvvOqTHJWzJqAQzbhFThfFqo5P311r
	 vZX1nSmyd2i4n6cxO0zCihLuw5ZhEA59Y99teMZoy+/4Lnw5P5yp8Z7DOeLCrn2CS
	 nGDN7Si726WNk9Wg0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1tvZ5V2Kuc-018OMw; Wed, 06
 Nov 2024 20:21:03 +0100
Message-ID: <42623eed-1220-4cdf-aa7f-3a9777a3da4b@gmx.de>
Date: Wed, 6 Nov 2024 20:21:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/20] ACPI: platform_profile: Allow multiple handlers
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-19-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-19-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o8eSaMAalEjM0ZyhsVSxQvpPnVmTFYgHq3Ee054ETZgdmd6+xTb
 YxaUbDIgDwhYEVRUXBlfdFKjJw6oRwJ+6kYU4MbBu98pb4NDeOpW6Vv1aItpTwlvcsHbwkF
 9XavgiRw7IzKtu+FuUXRaASQO7Oa3ap1w980WTxZnPqFzXshI2AyNWJzmI5CcXSJs+VVrrL
 zm9mBJy3C3Bia1CjLoejQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1xZ26NIqGEc=;J6MN4rHMSkzWlrqRF2TkHHyozXB
 HkFkzyNut79EjjfED1tVcx9lmA8Uy4Sv60nwlOsh00D9Jn9DVsk4ndmnm6OG5UWBEfgJMzbLr
 vNLunRYXRvzZJ8kbbT3F6VKrWfrZHv0gtyFfCYw69Lg4DFa7FuByYjCeolNrkCKg4jeGFJ8ka
 EQuagxiTc4AM/4gv80Le65J4XVAF+aIKc49DSANoZR5UqprZrgUCCVbvOz8qLAwGbsE6c9VCc
 Mjg4kqSA9Sc9Vsz5qIrqWj1HT65rNIiwasDFIk+Iur+U1XSpDZnDfB6e0RbtLKd5REVXzO9/R
 B2T1yPd5DK13sWp3vfZp0bgjLvgrWszmVjTpWNfR1rs7FORFPpltAyNsbcYbiknJlW2ZDc5Zk
 pQkRSFNOeo2GkV/pT58DOpa1vBS5UyV8VPAnRXKUapCYTvIgq/70C5mWmqHTQbny7hYJaRYpA
 X1dmYY2x9asqfVA5ur+jJAn/gW6izpRBLe4b5NrakySOrTUPZ8tCHQD0KCLvK7yx2mso1UwN9
 MxuLsps/8Iz/oldfahhvisgpVDgPGs6Imei1jfKM4EYqfTg4PpDe+Bhb/DcOcd6bFuY02KKU4
 GgqDl5yYgkqZjyi0vngKXQDe0IIKjr16CP7tgbIU5cyPBXlbf7whpAy2jgr1WDhRFmVGTCHdo
 gWMrQdTUlLAtY4YYmARteulmVf8chSr1M2GZxYi+7EePdJD4jZ8D0J5a0vp/xT0jN1dgVq/Gg
 50HUeLQeUqLmUKDlcIeoCXjF7bFT8WD0jEXfot3ozxR3WNZKQbcNz7aIrm5h1FHhC1xDxYuYF
 c2B4wv2xyJeGSR3CF8PfBaXTmLgY5j7SzF3t5/IZourOHPrCMqe8A8HnMV5YVWeo9o6q3gomr
 nxZThCO/Jg11eY1II7s+G+ycXDr76/JrrHtuBzbOu4N1sO3+py1Lwyo4I

Am 05.11.24 um 16:33 schrieb Mario Limonciello:

> Multiple drivers may attempt to register platform profile handlers,
> but only one may be registered and the behavior is non-deterministic
> for which one wins.  It's mostly controlled by probing order.
>
> This can be problematic if one driver changes CPU settings and another
> driver notifies the EC for changing fan curves.
>
> Modify the ACPI platform profile handler to let multiple drivers
> register platform profile handlers and abstract this detail from userspa=
ce.
>
> To avoid undefined behaviors only offer profiles that are commonly
> advertised across multiple handlers.
>
> If any problems occur when changing profiles for any driver, then revert
> back to the balanced profile, which is now required.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 568485e285061..b9eb25f58a2a2 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -10,7 +10,6 @@
>   #include <linux/platform_profile.h>
>   #include <linux/sysfs.h>
>
> -static struct platform_profile_handler *cur_profile;
>   static DEFINE_MUTEX(profile_lock);
>
>   static const char * const profile_names[] =3D {
> @@ -368,8 +367,7 @@ static const struct attribute_group platform_profile=
_group =3D {
>
>   void platform_profile_notify(void)
>   {
> -	if (!cur_profile)
> -		return;
> +	guard(mutex)(&profile_lock);
>   	if (!class_is_registered(&platform_profile_class))
>   		return;
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> @@ -428,9 +426,6 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>   	}
>
>   	guard(mutex)(&profile_lock);
> -	/* We can only have one active profile */
> -	if (cur_profile)
> -		return -EEXIST;
>
>   	if (!class_is_registered(&platform_profile_class)) {
>   		/* class for individual handlers */
> @@ -451,9 +446,9 @@ int platform_profile_register(struct platform_profil=
e_handler *pprof)
>   	if (IS_ERR(pprof->class_dev))
>   		return PTR_ERR(pprof->class_dev);
>   	dev_set_drvdata(pprof->class_dev, pprof);
> +
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
> -	cur_profile =3D pprof;
>   	return 0;
>
>   cleanup_class:
> @@ -467,13 +462,10 @@ int platform_profile_remove(struct platform_profil=
e_handler *pprof)
>   {
>   	guard(mutex)(&profile_lock);
>
> -	cur_profile =3D NULL;
> -
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>
>   	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
>
> -	cur_profile =3D NULL;
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_remove);

