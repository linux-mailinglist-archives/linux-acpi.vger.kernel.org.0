Return-Path: <linux-acpi+bounces-14761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4DDAEAE36
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 06:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F317A5512
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 04:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F21D86FF;
	Fri, 27 Jun 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klArCB9U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFE18DB35;
	Fri, 27 Jun 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000173; cv=none; b=JXBdxSoW87TEiZAYRbUIKsrH1Rjf2hrRxyNpKA72+aARPa4kvAKZD7SbHyziK24mohH5fCoYk/Zh+u8Oz2QEREhyP73BQzlEjzgLcWnlWI+oSLxcB6rLr3cw/JcAVFolJZF9rAYE/J8KSf2RyqslNFGqJoBm0ZE3EZwKWfBRcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000173; c=relaxed/simple;
	bh=IhiRrVHyVPn0A/ZdPezR9EoQUvZL5nukWhH425d93Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i72FXxSjIJAgNIOePBLEaIf2EsdBI2qAWpAuB1ZayGAnd0KJCV/iEJzttC8ceuZau8izs2VNWznHYE90zXnyJRZMSsYFmuQOFvWNKnfjC7kPiqBNVjOrW0BMb19QE61ydsF19fa2dGk0fJYPEdai/uwAr3ACKGPMXKy6496Pr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klArCB9U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1248675b3a.1;
        Thu, 26 Jun 2025 21:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751000171; x=1751604971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+MrdyFOXIC4Y5u1TiDSz8/gmnYUkl1eoQe+EDX6yl88=;
        b=klArCB9U+yXd6vX5OtoFIsLRZNWznbTtni8CTt3RVEr7TBYdsa2EoUN3P+0prPAXfv
         x6sJaXKImLE3Iai75kDOKk/WhviZAQulpA7vn7Mfbm3S/eF+yPJV3KtveL7q0ibUjrnq
         TEbNSJQuJhLykFIU1MwgDB+JGZFhEkuilwRN7tptmDaqaTW7GjrCJmV0GGx/sn1B6lDu
         t5DRi4lXr4WVv3lM/DK5TODoPtylWLvezqzDXYxzv3OqMV1kWCuJYUzzOx6CuyZqYdn5
         o6HU3fsMWDjJXZJI6Es6yJbypqVrMsQEtS8qOrLo8XFRTEpVUA1fI7ESQfl1G2Q8veN6
         +waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000171; x=1751604971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MrdyFOXIC4Y5u1TiDSz8/gmnYUkl1eoQe+EDX6yl88=;
        b=NvxoRQvmkUKGI7CaoA6YVJi4wTiGDga+WBXKmK2fCDL1QtTOFflwLmRh1DILn/7xJL
         PiqCQ5kYzwIYkM5thqHXtyaeQhddbLG90KNYsGnbu0rIUgPvVNDzWlpadjRuDoHLrqXM
         QzNMqjb2H1UnhxvkUytumORYPkzGvoT9IyczZxPK/Fv/ekO/ddT1tUQ9Z4GD2brPpmBK
         6X6db6V18wRebDUyHAiKun+CSFhehND45lTL7gnMY1qMeUtxl7NneI+mt1ZSc5jci7UW
         lixWgNC3hBrFSKG7+zs2bvfWJ64LJuRsVIzf+jQGe4fvv9A9En5u+aUbCc1xs0+agLxj
         hvDw==
X-Forwarded-Encrypted: i=1; AJvYcCUzqAmUrTfke1YmN7PE7mF9/HbLI2mwdYbNkXN7TZNSXu++F6I5fZ9xKFeCQ+NhaiKteMeRB/cjsMFY1zrH@vger.kernel.org, AJvYcCV7RSA7KpZSGySMs8TiQ1FIuRI4K503tlPNIf8mvTigLcqnl3Mt7yd/rFiLy3lXAK5M1hlEdEKeqvXa5g==@vger.kernel.org, AJvYcCWOQbuCwvyQ/+sYwP7o8nY2iQnpRh6qqUMOPw+nPNkLFjzyJQEgaBrYtAGwS/mEMEZI5DV2iFAG8vc+WD0=@vger.kernel.org, AJvYcCX+CXBSS/GVJ2slCn7iJ9ovnhYMzFoTxB224FNCZrwl2HKm7sPk4pUlOd7CIFKItW7oBapfHotR8klP@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwUY9msAE2YctmEY6i3XzQfuQ03iz+CqfIjs/euPi5Dcus6iV
	bgn1mUz4TR0Fca5AaW5KmSIkMSDPw2oV5mARMgRab61LxOZyG05/DtED
X-Gm-Gg: ASbGncsG2nJALl8uvpccAwr2O3XgNryoroR1MADT6NZiCcoTTeDVFxMP8bmEnrIWmCA
	t7rtJesKZttEmfnRs43GQhELttV4qPPQiO8hW5XdkSZbDc0U/VDE66yecJlPwHWm62ZRVZyJnSP
	CBqQX6VrWEBPhPYMWFTFTOI4PIKDSXbcL60RwR3nwgBwtBHd3BTFKE+lbL7kQzcBLNnrRUROocB
	RWI7HNVrrah20WCdn4QBZsn+wBFoHmvWaTaqXVTYMswXkjcBwc206IjsW6ABdx3PdpbTZa9VkQY
	xaDWt+hrRk0FDFRCSBwcODmotJPyZt7pnA3bcD3/bCbO4pyjGmhkpoU+SlrfOw==
X-Google-Smtp-Source: AGHT+IHznONadMYPcgLTqG7+syOd2eJWTrjST0N+svkcTt1ke5FV1m9p3Ui18oLYEM06Tm5z8MkI+Q==
X-Received: by 2002:a05:6a00:1820:b0:749:4cd:108e with SMTP id d2e1a72fcca58-74af6ef37e8mr2475301b3a.10.1751000170868;
        Thu, 26 Jun 2025 21:56:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d0c7:d92:6a17:eb62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5574390sm1329989b3a.90.2025.06.26.21.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 21:56:10 -0700 (PDT)
Date: Thu, 26 Jun 2025 21:56:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
References: <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>
 <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
 <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>

On Thu, Jun 26, 2025 at 05:21:35PM -0500, Mario Limonciello wrote:
> On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > 
> > > > On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
> > > > > On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> > > > > > > On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> > > > > > > > > On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> > > > [...]
> > > > > > > > > > I want to note this driver works quite differently than how ACPI power
> > > > > > > > > > button does.
> > > > > > > > > > 
> > > > > > > > > > You can see in acpi_button_notify() that the "keypress" is only forwarded
> > > > > > > > > > when not suspended [1].  Otherwise it's just wakeup event (which is what my
> > > > > > > > > > patch was modeling).
> > > > > > > > > > 
> > > > > > > > > > https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
> > > > > > > > > > [1]
> > > > > > > > > 
> > > > > > > > > If you check acpi_button_resume() you will see that the events are sent
> > > > > > > > > from there. Except that for some reason they chose to use KEY_WAKEUP and
> > > > > > > > > not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> > > > > > > > > multiple other platforms.
> > > > > > > > 
> > > > > > > > Interesting, but the ACPI button code presumably only does this on resume
> > > > > > > > for a normal press while the system is awake it does use KEY_POWER, right ?
> > > > > > > 
> > > > > > > Yes. It is unclear to me why they chose to mangle the event on wakeup,
> > > > > > > it does not seem to be captured in the email discussions or in the patch
> > > > > > > description.
> > > > > > 
> > > > > > I assume they did this to avoid the immediate re-suspend on wakeup by
> > > > > > power-button issue. GNOME has a workaround for this, but I assume that
> > > > > > some userspace desktop environments are still going to have a problem
> > > > > > with this.
> > > > > 
> > > > > It was done for this reason IIRC, but it should have been documented
> > > > > more thoroughly.
> > > > 
> > > > I assert that it should not have been done and instead dealt with in
> > > > userspace. There are numerous drivers in the kernel emitting
> > > > KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
> > > > what keys to process and when.
> > > 
> > > Please see my last message in this thread (just sent) and see the
> > > changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
> > > events").
> > > 
> > > This appears to be about cases when no event would be signaled to user
> > > space at all (power button wakeup from ACPI S3).
> > 
> > Ahh, in S3 we do not know if we've been woken up with Sleep or Power
> > button, right? So we can not send the "right" event code and use
> > "neutral" KEY_WAKEUP for both. Is this right?
> > 
> > Thanks.
> > 
> 
> I did some more experiments with this affected system that started this
> thread (which uses s2idle).
> 
> I only applied patch 3 in this series to help the debounce behavior and
> figure out impacts from patch 4 with existing Linux userspace.
> 
> If suspended using systemd in GNOME (click the GUI button) on Ubuntu 24.04
> the GNOME workaround mitigates this problem and no visible impact.
> 
> If I suspend by hand using the kernel interface and then press power button
> to wake:
> 
> # echo mem | sudo tee /sys/power/state:
> 
> * When GNOME is running:
> I get the shutdown popup and it eventually shuts down.
> 
> * When GNOME isn't running (just on a VT):
> System shuts down.

For the latter you may want to raise an issue with systemd, and for the
former I guess it is being too clever and does not activate the
workaround if suspend was not initiated by it? I think Gnome is being
too careful.

Thanks.

-- 
Dmitry

