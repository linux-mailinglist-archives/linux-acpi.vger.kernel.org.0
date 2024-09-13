Return-Path: <linux-acpi+bounces-8291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520C978AA7
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 23:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5001B243F3
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501B15575F;
	Fri, 13 Sep 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="ovws2alu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sonic306-20.consmr.mail.sg3.yahoo.com (sonic306-20.consmr.mail.sg3.yahoo.com [106.10.241.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5321714C3
	for <linux-acpi@vger.kernel.org>; Fri, 13 Sep 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263215; cv=none; b=XEwXZi9xKSvkc96v4ms90XVEnuBp0noIEKML6hJO+O93PaH0kgtcfr/vUVG+hfDbg1wq9xP/QpdlOJYJS9R+Y5o2Y9l0Zu+xj2VcKZw+R9mpXnJPrww2UNz9Xt3uCW41HYeN3ivpMnV3/yjmlcoPMKbh27boflwrQyFVgh6TrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263215; c=relaxed/simple;
	bh=GmIrA2s4GY1oMRi4z6JkX5QRAl/IPOLLybRw1y5NcVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK44ohNqGYrbkhPcT590c4/ZdjUfiXQKSTa4ckjW7ckXigm40c3n9E6pOYx3y812c5Tx+vJKeG9LqVOYsdVumdXjyQnqJyPmTVb2kX9pdPvJP3grNKmqYzIGBAD4JLqM0VQJlTWa4s/hWHgd2R7tiX0zJVyhW9+ngei6NloeOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=ovws2alu; arc=none smtp.client-ip=106.10.241.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1726263211; bh=Xu6GHo+mOurlZPXAopl8mYcnnDPP7yNRQ27zJInbkvY=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=ovws2aluJX84q4OF9a8PK/yZPP4zGZ/2BbuMXgaTw0f0w2mOOW1i9j0+uAttYumcKVvbkqdhu9m548r05R5KFU5ObslqjBIFTrbLCz4zRvV11oQuZgUbRq6UF8V8/kHC4DndjUN6ua7tAo9Ko/qdHLEhRmh0U4w3WYr7ceB0MUSfm36qhBO7qYnUVqYPRKP+2ni3tEseZ52vx/QW8aTbnljVOBW2x1VY021PLZwu0zwTq3Bfi2oy26RTu0iyfgci6yEb9YmOi7bh+kI0ORCKxtQz28M7h171Gm9V3sFRLg6xsAuICCcX8FoHVpDfRUbAXbsfEGot75bfvO7OGI3jJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726263211; bh=ZaqUjLlUcv9kNOwEEx/VznIcnFamu/ROzGEDkZJXG9m=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=KPn3JHTdX4nDlsjDo7Zmu0YkM3Vz1pn0jH9pPmYDXWLMGq5HWkb1NeWaoWgdWxcJIvOSGI6L7ugzDpc7BGIwEJ6rAE7HjH6nTpPZZdLioH8Z9VQ4/h+wZf6u8+B8BMh1pexhScrd03xxYEHRmPfmgh5SYN9H5o3jBtm2kBWnMDChweKYMu692c+ComUlMsBNDFkNMTRJTkK3EJ/4OMNnNgW+NdzdStMAE+9h92d3ZcI+lYdOT5yu0XUeRi1hX+NWLWYohjfNtrhKhidMSOoo7dcfB/EEeJoupAQ7XTwJGk9iaZ79KPdCOavXEVZ8MYHq93JGeqUHd22MX7oWZ+bJjg==
X-YMail-OSG: T1a7AU8VM1nEBDDmRIEmB83gfcR6TEZnkGY.R59_IFXClwu1o174uY7gEWGL_ui
 q6sqI1JYbvvbM.zu8nSQpDYRf5TOz_O.IzxHN2c3S6AronuxLTS.xqo7YohS3UDo8FvPzv8rSKLR
 CylFbbAhUHeg4LCYDnTmaBthPgq6DGdBOdsfxwpth0RqjgavOKos0SI83lw5ym1JumyyZZISX5xf
 vxkZLp0FDJclq8jVdYKqkT6KwsmOsl5H1YoJumjfOT5b.LiSw6ZCuMnmFE1Kx4O7GyAw7bb4BAKF
 xqX5c8lapGIqUttTGmx1rWfK56GjEgtX5AZq.rMGcuiP01KuCQ_KByvEeaI_LWerSBtssr2SBZFX
 mskZRxCeaGyNNVBNsqDC_QmFQfwTRZYElHgBTpYF_6q2R9omXNwA83bRfc7XMAydO4r4seFUYRu5
 NyW3S4u4DX3RBWq.vl0pWVWuuJb476GwVvTf7luAL6Q14EfudG5.cpWBPIdd7_6.U5USV1hUuMwG
 SNQ0oIHChAYcrvMt3cPgys5.GacrlRiqDa3Orn72_alVdgdTGMnjFj_b6Y0N.jqeZaQ9M0.AyYkK
 _7xUcw3Z.khd844wb4f2TWTGTBBna4ATRDshHqZ5VLTfHA228XP2Pb1jD_oAy48GE9nraDecmNRW
 X_mBZm7zmG3kRS6XW7vdkkMWl32YrHxIEUGTSVVqM9bF0M5DwaOunEPouq64nLac.oHxwHFX8NYS
 AkbESaevCFN1EF6CSW1OOXkMOLNkNAyZRI0d6ccx7SbSUuvUp_giXQifKL1NqlaaCVbQb1xLDiYQ
 mcJAGaI6RXMGfMFp2a7iBGlTH677SjCCgVRmxng5q5g8xG5DPkciCiI28H8AclzcqjUTw9XBecwR
 2oF1BO9e8HI9Iw0e2AIkwrHPpoNVinmgg4XHQnblWRYdl9SOE2OVkQ0d5k51dlLMjM44WCsUCsZk
 .1UzcepNGWbk.W4hhJDy4pVRsm8jrVmKZwcgtqR66i_B4gzE7LZ1bDJQlddTjAR1XTpbX7zFspsL
 qwqC0l1yUcTi4wtsttkg0.dvQsArtlB6BfLaPBG4yMFX3HmcS.A7WjNCMDAzqdZa3u6jWSV2h3SV
 cZnNOwFV7lHnYNIAZA01TKqKCutP8WZv8a6Y0lil5swZVv1zZatF4KbuCqK2Yj8ZoaI6FgkyOGz3
 MRfEy3cLcSiLrIkuCVtfgyM7Kj2uzqbIUvBKm5eyrsa.hZjnvJf3bHEdnF_60aNLYIHPHE.Ot70.
 PkOk9jhWxnW6KQqcroDvIftmKhQWGEEl74kE6GoBQBZ840SKO3VkRP0e8Ml4Ta0cl1bVrmRY5mev
 XqYWuIiwsAwPgfalpRe6X6TISReMLrCALRyDtMqECBDDzsiDN9hHlI_KyKE3K9b5TplH_dNDtf9s
 0rDmN3FNKa8owfVV_gBMJK_H0DcWYKqhm_zt6dQ1PAluT3FcGTBibvCUWoAUGFVg0P0qNTIsbOvk
 oMQoY.6WTshG0csW1YuVsoRhAC9S3aj4lrzvY9PV7Qg7cPn6JHlJ9m7QAev1GLlAZyCm4NmU5PEh
 vxOMw.X.3BS31g92QJVgckUiyJuR_HVBzjwk.PgXJOvJj71ZuxqW2zDkfjibx_cspYsaEU91eaK8
 ZsNckF2fgJEsnTm9Ypm8CuN_tgBD15ne_ax.OuIj3a.HoSfHG8pq6I1pinFpl2Am7C8jRZEIV1p2
 5INdxkdrOSOl5rzMqiG.LFxIfCP94iDghYEFVmD1zpvRrogWKwi5ffRLwATdy_Tu8IYffAdf3X4x
 hShfmcmJx04Qn0wFGhxdCHvxkzqdyInsgf5R8GPhD2EqacPk8ruJqloEQKV9q8.9KqK9b_1Tg44s
 YcZuQlJ_5N3Mf9SGLaZSxrJRPeRJMoMWFazD2DAVX2e.eSuaNC85ge1BTWjsy7Stt3tvXBEItpg7
 GsjNSqQl00HXOPGHmgCNGnDf0XfBhu9evSGSKtR1D2nvb.lxVokFMVtjIULQWwsBbb.M2p6uiTNn
 tDKeyIp6qdcuArb4c2sk8jUjhbgMQ41RlGbMwQdPOwYXlygRLgN46DiAUCbpB5j.MSzksOQQ0.7S
 6c1pKYSLAfN52XFgh6ori3SrxZlegEJxBW8A36izopVOIKgvjuQZcp4mmvZ79SADs_7HU_Px1K_F
 PCm1YTgtGK3WHAr8YMEfRHlOAYHZBiljPihzSPgUjmlbRw794n6BX9yb2uqobpi8SkDYJv4eMcNA
 V7m1iAOil4ic2noAR9FjLJQoPWHz.cnPtQGMxc47ndoM2p6RdoBY-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 17a4e484-a3c1-4e96-8a9c-8efecad89cbd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Fri, 13 Sep 2024 21:33:31 +0000
Received: by hermes--production-sg3-fc85cddf6-nnv8r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29fab85ab6d70373e5252eb4a6688490;
          Fri, 13 Sep 2024 21:23:21 +0000 (UTC)
Date: Sat, 14 Sep 2024 02:53:17 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: thermal: Use strscpy() instead of strcpy()
Message-ID: <pjfihdom7drxw5jse7kd2w5umjavlu5vb7v2p3svwz4eymqfkf@artgu4pefe5k>
References: <20240913191249.51822-1-abdul.rahim.ref@myyahoo.com>
 <20240913191249.51822-1-abdul.rahim@myyahoo.com>
 <c4e7b3ac-d8fa-47b9-84f6-e3332bb54e12@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4e7b3ac-d8fa-47b9-84f6-e3332bb54e12@wanadoo.fr>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, Sep 13, 2024 at 09:31:57PM GMT, Christophe JAILLET wrote:
> Le 13/09/2024 � 21:12, Abdul Rahim a �crit�:
> > strcpy() is generally considered unsafe and use of strscpy() is
> > recommended [1]
> > 
> > this fixes checkpatch warning:
> >      WARNING: Prefer strscpy over strcpy
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> 
> Hi,
> 
> in order to ease the review process, when you send a new version of a patch,
> the subject line should state the version: (i.e.: [PATCH v2] ...)
> 
> 
> It is also a good practice to explain what has changed with the previous
> version.
> Finally, it is nice to provide the link on lore to the previous version.
> All this should added below the first ---.
> Here it could look like:
> 
> > ---
> 
> Changes in v2:
>   - Remove an unneeded extra parameter (MAX_ACPI_DEVICE_NAME_LEN) in the 2nd
> strscpy() call
> 
> v1:
> https://lore.kernel.org/all/20240912205922.302036-1-abdul.rahim@myyahoo.com/
> 
> CJ
> 
> >   drivers/acpi/thermal.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 78db38c7076e..6671537cb4b7 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -796,9 +796,9 @@ static int acpi_thermal_add(struct acpi_device *device)
> >   		return -ENOMEM;
> >   	tz->device = device;
> > -	strcpy(tz->name, device->pnp.bus_id);
> > -	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> > -	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> > +	strscpy(tz->name, device->pnp.bus_id);
> > +	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> > +	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> >   	device->driver_data = tz;
> >   	acpi_thermal_aml_dependency_fix(tz);
> 
> 

Thanks CJ,

https://lore.kernel.org/all/20240913211156.103864-1-abdul.rahim@myyahoo.com/

