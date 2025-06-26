Return-Path: <linux-acpi+bounces-14709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3CAEA4E9
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D8A562BE0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963BC2EBDFF;
	Thu, 26 Jun 2025 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG5V7TOV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07731D5170;
	Thu, 26 Jun 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961266; cv=none; b=hFkJuBZh9K00+ZQkAo5rCoemL5aOMr8VVDi6qWYBe7W4TVZy8sSxjHU5r1hdmnCkJ/zJPhhuDfDmMOYZSqN9mXFok8QOAHYRKGiLktK67+t+YgHAULtLh/o8s85lJDXtnzXdEUPBWpIvS+evOZ280mL8p9sr/7jPY8+afZRO0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961266; c=relaxed/simple;
	bh=s9x6dxudyjRS9durYlnGruJYjvUGIGYo6npJKPm0fB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5pihdQUcblIsFsrU5kaaH+Qf9PW0PFZskm8NdI3t+gXjBrNflJ6cDup8Q+kv9MrXV/Ss27kBZ4W77pKFJhIII53A985Sm0Khx6EKI/Sg3+/npXVffaUAt07EISipv6F97iDO/jVFNA7DozXHLE1BgHuqViLU6nexHJqziJGlsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG5V7TOV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2363497cc4dso13690585ad.1;
        Thu, 26 Jun 2025 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750961264; x=1751566064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Anccgxz8ioAQ/FehorCp97CbyBsNiWT7FvoW6DOnuQM=;
        b=BG5V7TOVtgkS+0/L2TB6WUJTU8tvknuexgCn+EmchFRZXWEI4xUQLakt0BJruQblVS
         9y+VPkWP+8xo47GKFcAskA2/zjSD2HEI1Ik5+S1NWhIs8svg/+LC/r4Vwd56ta3drwXW
         V3FNY3SgvJCsiMKoWatJiEQZ1kdq++C31VErloGYvV8oxCg6YAWex0EiqKzRjTRxeZyt
         +qi/rrhURVvX3urGQYfLSiFLnwcT9Q18Foj1ThOcLx/5R0HwBIMKnqz72qVuu9IoDQXB
         +pqNCE4BLvKsIumLkjrkEzbK4QPFCtLd9ILdLAWTVIMXRi5petCse+eC9/kHdZ/I48qg
         psWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750961264; x=1751566064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Anccgxz8ioAQ/FehorCp97CbyBsNiWT7FvoW6DOnuQM=;
        b=w8Hnxt+Gq5WPapgtvfR0XJzJM3lS7aOTBmrEuiE/CjeHp9crAk19LjiWSS/ZJ7e8nA
         Po8w6vrkPyneD0UV15LlqZtibzrIsj9AtapU+IGQ3WffsUsonyDWyX1aJFCfRDGFij4B
         lhDurA7FICQIDm7TT1zR64t1+GYEsSLCLWXfTZ+N5XlfHOgugVNGP2UZK8AkktyyKpwG
         xptOx3SCtEBUKCatDjbxBfAq4NSWSzJ85YT3UBA3RT69j8vwIhXuh4YsgVd4QNMBls7y
         KENkawp3z8WWHOGURk2xVzQsZQ+194lH4M0jvZf/vd/esxcgOsV+IHCeBDRujvvPKWX3
         3BGw==
X-Forwarded-Encrypted: i=1; AJvYcCUsZMSA0+Hr409JL4kssjwYFGTi0jtCHx06ZoF+z1pQo1LSduUXCal9X1Zh2M8IW3KMd3fdxbJqu6ihxA==@vger.kernel.org, AJvYcCUu2Y5LFYWqMJ/Tbu9rEKugyT9MNiA0Z8F3Q3mpheoJZ6JJZ/p8RchfhUm/nqdQ2MdSN+ZeTvNUuu2g4IIc@vger.kernel.org, AJvYcCX6l5Rvfyucl1Pem5XsOTe0+dpHhyW8dYR9sScJ+8gn2gNch7F+w/kdYUV1pqg+SZzrRGwrn96rvkBrgmM=@vger.kernel.org, AJvYcCX9bxP5ufEHbVEdD2RxpSraDsAaiDooZbqXdE9lsYqrMPEOW6hZ4fb/BDiwOkvzlFWDuapGO9AgeOl7@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJKeRE4LZMRVKu8493Z5jGwogX+2cPBPfiCbrKEn7wV+iiNqI
	KMx0LCvhmI7wGTAwVCOvEhOLVw8Bm1XcAX5MR0B05QIoEwcfhHqHSF5Da7YxVw==
X-Gm-Gg: ASbGnctlWegnHK3y9rld110JARHL/VOe+YZ1Y28OYX30i5So3U5bbJHV0ISErmxjiq7
	hagoZKAvI3gYIG8htJlPHWERtN+RMRV5+S/wmCOUxUdJRJvWwgHIjyprj7D4vBcyCR4m+jvBm01
	dCy/lYxZB1+vbUKK7n4wbK1eQfwLGi6dNq7NIjUZE08xkwHqZekdChMDwQsvnylC7RvVT5veZ75
	Nk6VEloB7nQx1jG4WCa7xl9/SmgAcK8UPFEUBHbWLqzeE7IFEXisqBWEtfKRccFM9bcPWTIAriQ
	nPkC/O4fOpMp/omwmOZ/yafX2D9t55DMa3TXMSakdq5IfSXPtWERws36QDYoexk=
X-Google-Smtp-Source: AGHT+IHRrMPthSLR2hySukimOy0SgmAYGGUGgUW/V+UP4Nhki2DlSmyuhAPLRzU/2oBAiHJxrCWglQ==
X-Received: by 2002:a17:902:c94c:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23ac3afd0d2mr4689205ad.16.1750961264017;
        Thu, 26 Jun 2025 11:07:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c8f:acd3:efcb:bc3d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c44730c6sm2154595a12.60.2025.06.26.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 11:07:43 -0700 (PDT)
Date: Thu, 26 Jun 2025 11:07:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>

On Thu, Jun 26, 2025 at 12:53:02PM -0500, Mario Limonciello wrote:
> 
> 
> On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
> > Hi Mario,
> > 
> > On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
> > > 
> > > 
> > > On 6/26/25 3:35 AM, Hans de Goede wrote:
> > > > Hi Mario,
> > > > 
> > > > On 25-Jun-25 23:58, Mario Limonciello wrote:
> > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > 
> > > > > Sending an input event to wake a system does wake it, but userspace picks
> > > > > up the keypress and processes it.  This isn't the intended behavior as it
> > > > > causes a suspended system to wake up and then potentially turn off if
> > > > > userspace is configured to turn off on power button presses.
> > > > > 
> > > > > Instead send a PM wakeup event for the PM core to handle waking the system.
> > > > > 
> > > > > Cc: Hans de Goede <hansg@kernel.org>
> > > > > Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > ---
> > > > >    drivers/input/keyboard/gpio_keys.c | 7 +------
> > > > >    1 file changed, 1 insertion(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > > > > index 773aa5294d269..4c6876b099c43 100644
> > > > > --- a/drivers/input/keyboard/gpio_keys.c
> > > > > +++ b/drivers/input/keyboard/gpio_keys.c
> > > > > @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
> > > > >    		pm_stay_awake(bdata->input->dev.parent);
> > > > >    		if (bdata->suspended  &&
> > > > >    		    (button->type == 0 || button->type == EV_KEY)) {
> > > > > -			/*
> > > > > -			 * Simulate wakeup key press in case the key has
> > > > > -			 * already released by the time we got interrupt
> > > > > -			 * handler to run.
> > > > > -			 */
> > > > > -			input_report_key(bdata->input, button->code, 1);
> > > > > +			pm_wakeup_event(bdata->input->dev.parent, 0);
> > 
> > There is already pm_stay_awake() above.
> 
> But that doesn't help with the fact that userspace gets KEY_POWER from this
> and reacts to it.
> 
> > 
> > > > >    		}
> > > > >    	}
> > > > 
> > > > Hmm, we have the same problem on many Bay Trail / Cherry Trail
> > > > windows 8 / win10 tablets, so  this has been discussed before and e.g.
> > > > Android userspace actually needs the button-press (evdev) event to not
> > > > immediately go back to sleep, so a similar patch has been nacked in
> > > > the past.
> > > > 
> > > > At least for GNOME this has been fixed in userspace by ignoring
> > > > power-button events the first few seconds after a resume from suspend.
> > > > 
> > > 
> > > The default behavior for logind is:
> > > 
> > > HandlePowerKey=poweroff
> > > 
> > > Can you share more about what version of GNOME has a workaround?
> > > This was actually GNOME (on Ubuntu 24.04) that I found this issue.
> > > 
> > > Nonetheless if this is dependent on an Android userspace problem could we
> > > perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
> > 
> > No it is not only Android, other userspace may want to distinguish
> > between normal and "dark" resume based on keyboard or other user
> > activity.
> > 
> > Thanks.
> > 
> In this specific case does the key passed up to satisfy this userspace
> requirement and keep it awake need to specifically be a fabricated
> KEY_POWER?
> 
> Or could we find a key that doesn't require some userspace to ignore
> KEY_POWER?
> 
> Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?

The code makes no distinction between KEY_POWER and KEY_A or KEY_B, etc.
It simply passes event to userspace for processing.

You need to fix your userspace. Even with your tweak it is possible for
userspace to get a normal key event "too early" and turn off the screen
again, so you still need to handle this situation.

Thanks.

-- 
Dmitry

