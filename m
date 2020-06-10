Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2C1F5E6E
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jun 2020 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgFJWnK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 18:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJWnJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2020 18:43:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46FC03E96B;
        Wed, 10 Jun 2020 15:43:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so1423507pje.4;
        Wed, 10 Jun 2020 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2mg+YttgENHXjRIUtb4vyDZuQUaaeI5RLdU6PJRUtdQ=;
        b=FtzHHqy6K+fjV+6Pux67Eyo1b/0Hxc2LXCMESRP64FVaOjBK3sbVFOj9snBa5yPwko
         oQixl35rYI3iK1k1AeKz3i/AApjU3blABn4EXQU1fc0SfmCVDw0BxxSbyqttHVEGrpl/
         /72lrnrWo9YsrTqLEYq8FBdQai05NcqFNEy0pM/UrbiWNsCsKix6aoPUagdbjGBQTKz2
         GXecUCGJ+zbgELo5PK3mZNpGCrLABLbmtRL2tkBA5m64jFOAmuDWwoHB0j6mEa4DNYbK
         W3No7+Semq6QAUvOsNLX9nOdY1qelBXzTXmj+OUo17tJTE3mwixXLvbEQNk8QULZbjqj
         xYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2mg+YttgENHXjRIUtb4vyDZuQUaaeI5RLdU6PJRUtdQ=;
        b=PqjzGYOuvzt+GqU013OsapuYg94J4zrWyAiUKJz3i7Pu2ivPVdndCJM9Xkqvn8SNyJ
         bI2kOBVjZjmcYEdVtQwxjBN2QberOhQhIh1TaERbOVLIdRBqtJydqpe+FSwCOgs6+0Em
         EfhkSZO5+F/ooiamwM7OlTlw1A+tp+Q5A9YzyqSewtn2BtT/+Pr+HdWyVfzxG197ZmQF
         0Tgud9IRVG3xmKjx450m/w8197DYeavOSgrK1Ib81YSijsemJGI9zwjZ6UxtZaAZLRVY
         ldBiD3DV2D283H5Pd6NG3gPjoOSdx1KHWfl1g4Ju+kExh50qwRpGjA77FZu7Tsdgylio
         HqSA==
X-Gm-Message-State: AOAM530Hg5wNG6dUiuxB3soNoqxGJEvzEJNb2+mVkRg7FBbQN8cUUkmy
        ee46g4msEDtwZGdbsYKd+p8=
X-Google-Smtp-Source: ABdhPJy37/Sf8L8fVwa35S1cZE7A/66QgoXafLcN6YFX+TN/ZDLflUCR3U3QEiNli51Y1563eKMSRg==
X-Received: by 2002:a17:902:a502:: with SMTP id s2mr4884310plq.267.1591828988742;
        Wed, 10 Jun 2020 15:43:08 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id m7sm965668pfb.1.2020.06.10.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:43:07 -0700 (PDT)
Date:   Wed, 10 Jun 2020 15:43:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mario.Limonciello@dell.com
Cc:     enric.balletbo@collabora.com, rjw@rjwysocki.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        lenb@kernel.org, kernel@collabora.com, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org, ayman.bagabas@gmail.com,
        benjamin.tissoires@redhat.com, blaz@mxxn.io, dvhart@infradead.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        jeremy@system76.com, 2pi@mok.nu, mchehab+samsung@kernel.org,
        rajatja@google.com, srinivas.pandruvada@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Message-ID: <20200610224305.GC248110@dtor-ws>
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
 <10490419.gsntqH5CaE@kreacher>
 <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
 <59771d3689da41a5bbc67541aa6f4777@AUSX13MPC105.AMER.DELL.COM>
 <20200610214033.GB248110@dtor-ws>
 <adf9daaf08f1464684e48ec203194fe9@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf9daaf08f1464684e48ec203194fe9@AUSX13MPC105.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 10, 2020 at 09:52:12PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Sent: Wednesday, June 10, 2020 4:41 PM
> > To: Limonciello, Mario
> > Cc: enric.balletbo@collabora.com; rjw@rjwysocki.net; rafael@kernel.org;
> > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; lenb@kernel.org;
> > kernel@collabora.com; groeck@chromium.org; bleung@chromium.org;
> > dtor@chromium.org; gwendal@chromium.org; vbendeb@chromium.org;
> > andy@infradead.org; ayman.bagabas@gmail.com; benjamin.tissoires@redhat.com;
> > blaz@mxxn.io; dvhart@infradead.org; gregkh@linuxfoundation.org;
> > hdegoede@redhat.com; jeremy@system76.com; 2pi@mok.nu;
> > mchehab+samsung@kernel.org; rajatja@google.com;
> > srinivas.pandruvada@linux.intel.com; platform-driver-x86@vger.kernel.org
> > Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Wed, Jun 10, 2020 at 09:28:36PM +0000, Mario.Limonciello@dell.com wrote:
> > > >
> > > > To give you some references, if I'm not wrong, this prefix is used in
> > all
> > > > or
> > > > almost all Intel Chromebook devices (auron, cyan, eve, fizz, hatch,
> > > > octopus,
> > > > poppy, strago ...) The ACPI source for this device can be found here
> > [1],
> > > > and,
> > > > if not all, almost all Intel based Chromebooks are shipped with the
> > > > firmware
> > > > that supports this.
> > >
> > > You can potentially carry a small patch in your downstream kernel for the
> > > legacy stuff until it reaches EOL.  At least for the new stuff you could
> > > enact a process that properly reserves unique numbers and changes the
> > driver
> > > when the interface provided by the ACPI device has changed.
> > 
> > If we use this prefix for hatch EOL is ~7 years from now.
> > 
> 
> Isn't the whole point of the ACPI registry and choosing an ID?  You know internally
> if you need to change the interface that a new ID is needed and a new driver will
> be needed that comprehends that ID change.  So if you can't guarantee that 0001 is
> the same driver interface in every firmware implementation google used then that is
> where this falls apart.
> 
> I know there is a long support lifecycle but you're talking about rebasing
> to new LTS kernels a handful of times between now and then.  If the interface really
> is stable the patch should be small and it shouldn't be a large amount of technical
> debt to carry downstream until EOL.

I think we are talking about different things actually. Let's forget
about Chrome OS and downstream kernels. We have devices that have
already been shipped and in hands of users. Some of them are old, some
of them are new. We can't not enforce that firmware for these devices
will be either released or updated. Therefore, if we want expose this
device in mainline kernel, we need to have it handle "GGL0001" HID in
addition to whatever proper HID we may select for it.

We internally can fix it (HID) for next generation of devices.

Thanks.

-- 
Dmitry
