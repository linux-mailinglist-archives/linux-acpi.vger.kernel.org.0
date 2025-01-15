Return-Path: <linux-acpi+bounces-10687-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9FCA1264A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 15:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8ED1887AA1
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01D678C9C;
	Wed, 15 Jan 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmbIOxnE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5624A7CC;
	Wed, 15 Jan 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952117; cv=none; b=Y6SB7Jg+9A5KStfYyOOqS/t7uN3CiIuRbFmknGEweyDr7YgZSxxFIJfPGhkHf8y0aPNOMKRnaf8FPdZutxFNVhUXv67yKPwM6IAZspwCdJOlrhL67xU8eUJUK/ypJcq4vb9dur+OXzHuU19ZkmMrubZvJ4eCBbD/IASjDndsL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952117; c=relaxed/simple;
	bh=uf5q5nR7K3Imf5x3dYbMKzK+Aoh4Ju+D30UvqpqQ/kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1JPO+RLZw5kSn9uF3HUXuT/ToxZPwM8PkFgJpF1QtoP44tqdmOT72MKy2Bzn+XB4WiiIpY4l0+xsP8KnNLzZ2VFEgFSt5OVbvB939WuYhf0EkwF83vEq06tSXDq4HtaoqNFHelqyIbNO0TeayD1UkTV5n18MVC1tYpxYyp3CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmbIOxnE; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e461015fbd4so9749769276.2;
        Wed, 15 Jan 2025 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736952115; x=1737556915; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KxvIljh6afNT9xoNdKrI+27ipwmt2qwXhsTGdV3Ik+4=;
        b=MmbIOxnE4T3XJYpZtZgP3ePhJ839MrQE0CN3O1QOBSWuAbPVPQT8OM6rRjKBylPK2g
         N4b8LhvHhqDZCFH0CDbh3gMhwLrLpkvQFEwQLT5WfTCwow5xo9vCqSm5yq5uMM/PNb6l
         WoU1jTmntk+HJr2wy9fJkZ3wFhaGEo/Xx2c9y/hmWjBEFTG9PIt5mh5RmGNRXGRy9GLS
         9vk1E3LhqsPjW3Dx1uWccpThcrlEnk23BHdfV7A9YlqzCHt+IIAH6YY0G1GZvYnhUPEF
         Js+76N6OhjNWANsUl48pCkKnQSgqKX8kWm11gAog4zcik0XqMQBDy/GU6p0gtHk0sLI8
         +7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952115; x=1737556915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxvIljh6afNT9xoNdKrI+27ipwmt2qwXhsTGdV3Ik+4=;
        b=bKbjvBgWv44Xo3CEhiZWjtz5djWB5w4ab6lDVviBwaYw61a2ATah7RYsyCKu32jzpX
         RFUImbp5w5aUIRBjxc/PYUmrR2RV69ST8faWPuz31lfsoD/iC7F1b2aV6A3OJdf/gcOk
         YVcLr+ADcxHJUe3+U0uaSAapDyf9MROF4DtCZWdkIyR8YZFt/MvSxSjTEpdUQwMKqFMQ
         qjL3hiaLe0lmV2K5DQyY4yeGVbctCPDi7r4cflia7VLZmpKY0VAVaq1t8PaF18qBBUwc
         M9JAGlcSgRcYjurMkiC1ACIuBVsrtpuTUrm7ii0BXORJZOo/bkbZUiTzBbSyxTpUpLCq
         GBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8sgL23/+ggv4Vo9gu84BDJuapYFYeSUokLtnIYEchN/Svc+R5OsPAWOSxbAyT61HZF3hCbckIKEp4@vger.kernel.org, AJvYcCXqEt1IE3gN3S6QZKHNRWbOjSKnP7o/Aw0DLgjqRoPCsfej6JwqTjYmFizLLaeBgqtgj20IpWaoenheTGJf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/QcNjGXlyiOPZq+EZ3GAtb2Q/cx6r53HU2vqZ2DRIzSbBGHm0
	FsC31Jbltd59zxGF+AcbmkP//qDDAHTsA3a1q4H6+iaNbObBQ9lv
X-Gm-Gg: ASbGncty7JgmO2/C6QpfEvxQwD1tHg3nTRuy9BekpF+o86ZXP3PkGZ5aCr75VCQMoWE
	3XdRvYHJOVTefOdWz05p7HBBdn59hQTRiQEi8Orqweqk3LGlZsy6TM8mbgPqF7drvPiZE9Qghba
	PxLuvCs9rlNto+UjzPVSHATW2707Bg0sjvcUio/IJvejd2YsI14iYbgADrNg71NPC4rDrwKD6W5
	7WoBLlX2L5Kyi7EzYmLAvmM6wpwJ3dsg+DE3LkXhavWY8x/dr4f6Q==
X-Google-Smtp-Source: AGHT+IHhXPLvl4jmA8MfwgjX7fTyAqrVS0P5ljIIeeMJD5AyQnklj6yPtxgkjrB7DdcifBDQg7Ko7w==
X-Received: by 2002:a05:690c:9b0c:b0:6ef:4a1f:36aa with SMTP id 00721157ae682-6f53125ed2cmr251666027b3.20.1736952115109;
        Wed, 15 Jan 2025 06:41:55 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546dd70b5sm25125037b3.78.2025.01.15.06.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 06:41:54 -0800 (PST)
Date: Wed, 15 Jan 2025 09:41:50 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
	Ike Panhc <ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Alexis Belmonte <alexbelm48@gmail.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
	ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 09/19] platform/x86: asus-wmi: Use
 devm_platform_profile_register()
Message-ID: <cknsfiukbw4uivdizha3orlgaee2haw2zdd4dpqikhmvspzdyt@riyt27f7lrtn>
References: <20250115071022.4815-1-kuurtb@gmail.com>
 <20250115071022.4815-10-kuurtb@gmail.com>
 <9a00d65e-01a8-007f-9918-44b21b194803@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a00d65e-01a8-007f-9918-44b21b194803@linux.intel.com>

On Wed, Jan 15, 2025 at 04:08:35PM +0200, Ilpo Järvinen wrote:
> On Wed, 15 Jan 2025, Kurt Borja wrote:
> 
> > Replace platform_profile_register() with it's device managed version.
> > 
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/platform/x86/asus-wmi.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index 3d77f7454953..f8437cff66df 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3895,12 +3895,12 @@ static int platform_profile_setup(struct asus_wmi *asus)
> >  	asus->platform_profile_handler.dev = dev;
> >  	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
> >  
> > -	err = platform_profile_register(&asus->platform_profile_handler, asus);
> > +	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
> >  	if (err == -EEXIST) {
> >  		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
> >  		return 0;
> >  	} else if (err) {
> > -		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
> > +		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
> 
> Hi,
> 
> I'm sorry I didn't notice this while passing through the patches 
> yesterday.
> 
> Could you please make this error message plain english instead of piling 
> even more kernel C specifics to it? Preferrably, an user seeing a kernel 
> error message should not be required to know/understand any C, so don't 
> print __func__ nor write function names into any error/warning/info level 
> messages.

Hi,

Sure!

> 
> Also, it should use dev_err() I think (platform_profile_setup() seems to
> mix pr_*() & dev_*() prints with no good reason).

I also think this should be dev_err, but I don't know this driver
enough. Also I think driver specific platform_profile_register error
messages are a bit redundant, as platform_profile_registers already logs
most important failures with dev_err.

~ Kurt

> 
> -- 
>  i.
> 
> >  		return err;
> >  	}
> >  
> > @@ -4859,8 +4859,6 @@ static int asus_wmi_add(struct platform_device *pdev)
> >  fail_sysfs:
> >  fail_custom_fan_curve:
> >  fail_platform_profile_setup:
> > -	if (asus->platform_profile_support)
> > -		platform_profile_remove(&asus->platform_profile_handler);
> >  fail_fan_boost_mode:
> >  fail_platform:
> >  	kfree(asus);
> > @@ -4886,9 +4884,6 @@ static void asus_wmi_remove(struct platform_device *device)
> >  	throttle_thermal_policy_set_default(asus);
> >  	asus_wmi_battery_exit(asus);
> >  
> > -	if (asus->platform_profile_support)
> > -		platform_profile_remove(&asus->platform_profile_handler);
> > -
> >  	kfree(asus);
> >  }
> >  
> > 

