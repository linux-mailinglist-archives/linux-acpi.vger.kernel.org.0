Return-Path: <linux-acpi+bounces-6862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C02092EA7A
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F5D1C215E2
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCC167271;
	Thu, 11 Jul 2024 14:16:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DD80BF8;
	Thu, 11 Jul 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707389; cv=none; b=NcpzENcfta8t+jw81Rqjga925Zt4O5E4svvVH3WjeDj9TT1W9nJuwspSyaAo6BfRyZ83uzKeSL8E3oGb9KCupoINcA4dSp5CjnrtpaHxbHd61yIGIL/QIb7tycOPDmlgRLvjGKXqr0WeDA1SECHC7R/me+UsKZ2CyxkF7jEmQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707389; c=relaxed/simple;
	bh=a9pdGR6wfxP8Mqh0V6yErEEF9QRi8fjHjcnxSjYsoJk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ia/J7COLeWXcGAc2RHB/kU3RYJtdjXqBYlci/Z3v/RmOIlVka7q/td3i6tDCcu+7f2LHf9WZpzwTOHNp+PXavO1c3itR8+bPuyvIMBcfgCY5NBTGBRAmggCQEQ6o7Qq+X44HNFgeFGMgWwP/BvpjesfKBbqYHsIvpf3VlzKXLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1sRuaU-002GpR-2F; Thu, 11 Jul 2024 15:15:58 +0100
Date: Mon, 08 Jul 2024 09:28:18 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/6=5D_leds=3A_bd2606mvv=3A_use_device=5Ffor?=
 =?US-ASCII?Q?=5Feach=5Fchild=5Fnode=28=29_to_access_device_child_nodes?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4cf71de7-dc47-475c-bba0-a9e755f66d49@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com> <20240706-device_for_each_child_node-available-v1-3-8a3f7615e41c@gmail.com> <20240707175713.4deb559f@jic23-huawei> <4cf71de7-dc47-475c-bba0-a9e755f66d49@gmail.com>
Message-ID: <6119CC81-5F47-4DA3-8C9C-98C7C87C9734@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 36

No

On 8 July 2024 09:14:44 BST, Javier Carrasco <javier=2Ecarrasco=2Ecruz@gma=
il=2Ecom> wrote:
>On 07/07/2024 18:57, Jonathan Cameron wrote:
>> On Sat, 06 Jul 2024 17:23:35 +0200
>> Javier Carrasco <javier=2Ecarrasco=2Ecruz@gmail=2Ecom> wrote:
>>=20
>>> The iterated nodes are direct children of the device node, and the
>>> `device_for_each_child_node()` macro accounts for child node
>>> availability=2E
>>>
>>> `fwnode_for_each_available_child_node()` is meant to access the child
>>> nodes of an fwnode, and therefore not direct child nodes of the device
>>> node=2E
>>>
>>> Use `device_for_each_child_node()` to indicate device's direct child
>>> nodes=2E
>>>
>>> Signed-off-by: Javier Carrasco <javier=2Ecarrasco=2Ecruz@gmail=2Ecom>
>> Why not the scoped variant?
>> There look to be two error paths in there which would be simplified=2E
>>=20
>
>I did not use the scoped variant because "child" is used outside the loop=
=2E

Ah missed that=2E  Good sign that things are wrong=2E=2E=2E

>
>On the other hand, I think an fwnode_handle_get() is missing for every
>"led_fwnodes[reg] =3D child" because a simple assignment does not
>increment the refcount=2E

Yes=2E Looks like a bug to me as well=2E


>
>After adding fwnode_handle_get(), the scoped variant could be used, and
>the call to fwnode_handle_put() would act on led_fwnodes[reg] instead=2E

There looks to be another bug as it only frees one handle on error=2E  Rig=
ht now it shouldnt free any but once you fix that you will need to free any=
 not freed otherwise=2E

Can it be squashed into one loop?

J


>
>>> ---
>>>  drivers/leds/leds-bd2606mvv=2Ec | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/leds/leds-bd2606mvv=2Ec b/drivers/leds/leds-bd260=
6mvv=2Ec
>>> index 3fda712d2f80=2E=2E4f38b7b4d9d1 100644
>>> --- a/drivers/leds/leds-bd2606mvv=2Ec
>>> +++ b/drivers/leds/leds-bd2606mvv=2Ec
>>> @@ -69,7 +69,7 @@ static const struct regmap_config bd2606mvv_regmap =
=3D {
>>> =20
>>>  static int bd2606mvv_probe(struct i2c_client *client)
>>>  {
>>> -	struct fwnode_handle *np, *child;
>>> +	struct fwnode_handle *child;
>>>  	struct device *dev =3D &client->dev;
>>>  	struct bd2606mvv_priv *priv;
>>>  	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] =3D { 0 };
>>> @@ -77,8 +77,7 @@ static int bd2606mvv_probe(struct i2c_client *client=
)
>>>  	int err, reg;
>>>  	int i;
>>> =20
>>> -	np =3D dev_fwnode(dev);
>>> -	if (!np)
>>> +	if (!dev_fwnode(dev))
>>>  		return -ENODEV;
>>> =20
>>>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> @@ -94,7 +93,7 @@ static int bd2606mvv_probe(struct i2c_client *client=
)
>>> =20
>>>  	i2c_set_clientdata(client, priv);
>>> =20
>>> -	fwnode_for_each_available_child_node(np, child) {
>>> +	device_for_each_child_node(dev, child) {
>>>  		struct bd2606mvv_led *led;
>>> =20
>>>  		err =3D fwnode_property_read_u32(child, "reg", &reg);
>>>
>>=20
>

