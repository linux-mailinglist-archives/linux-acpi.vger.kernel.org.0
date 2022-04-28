Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC455133F6
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Apr 2022 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346476AbiD1Mop (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Apr 2022 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346408AbiD1Moa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2022 08:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD4122508;
        Thu, 28 Apr 2022 05:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C7262021;
        Thu, 28 Apr 2022 12:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F75C385A0;
        Thu, 28 Apr 2022 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651149670;
        bh=H/3u/CcX1d8+DE8rBf/zqVY14MTJASBdkzizEGaA2gY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOs9EWCWVLCEqaXtG5zXHSqfUuRcmK39Gie4feWGqoBCMY4fVcqunoM19Ioq6fRIc
         byprs6MT8/Jv0cCj152QLuSmmdW2NKovaPcLqTSz0eljrwzmXO/Tu1YLeOZZcM+JLD
         fYMjWMp6IbARFh8usL2icsBGfCEQOLuqwjToGTbg=
Date:   Thu, 28 Apr 2022 14:41:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8] platform: x86: Add ChromeOS ACPI device driver
Message-ID: <YmqLYyUY3sutmMTI@kroah.com>
References: <Ylmmf03fewXEjRr0@debian-BULLSEYE-live-builder-AMD64>
 <YmUNnq5tH8mykNOF@kroah.com>
 <c195573c-e7c7-a2dd-7f29-c6d4625fefdb@collabora.com>
 <YmqLKBVPMl4AFzCE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmqLKBVPMl4AFzCE@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 28, 2022 at 02:40:08PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 28, 2022 at 05:24:04PM +0500, Muhammad Usama Anjum wrote:
> > On 4/24/22 1:43 PM, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 15, 2022 at 10:08:15PM +0500, Muhammad Usama Anjum wrote:
> > >> +	i = 0;
> > >> +	list_for_each_entry(aag, &chromeos_acpi.groups, list) {
> > >> +		chromeos_acpi.dev_groups[i] = &aag->group;
> > >> +		i++;
> > >> +	}
> > >> +
> > >> +	ret = sysfs_create_groups(&dev->kobj, chromeos_acpi.dev_groups);
> > > 
> > > You have raced with userspace and lost here :(
> > > 
> > Sorry, What does it mean exactly?
> 
> Long old post that describes the issue in detail is here:
> 	http://www.kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
> 
> > > Use the default groups pointer in the platform driver for this, and use
> > > the is_visible() callback to know to show, or not show, the attribute
> > > instead of building up dynamic lists of attributes at runtime.  That
> > > will save you lots of crazy logic and housekeeping _AND_ userspace tools
> > > will work properly as well.
> > > 
> > 
> > Driver has the 2 kinds of attributes:
> > 
> > A) Attributes which are always there. For example, CHSW and HWIDs etc.
> > They can be easily shows via dev_groups pointer in platform driver.
> 
> Great.
> 
> > B) Attribute groups which vary between 0 to N. N is platform dependent
> > and can be determined at runtime. For example, GPIO attribute group
> > which have 4 sub attributes in it:
> > 
> > Group GPIO.0 --> attributes GPIO.0, GPIO.1, GPIO.2 and GPIO.3
> > Group GPIO.1 --> attributes GPIO.0, GPIO.1, GPIO.2 and GPIO.3
> > ...
> > Group GPIO.N --> attributes GPIO.0, GPIO.1, GPIO.2 and GPIO.3
> > 
> > My Chromebook has 2 GPIO attribute groups while I've found logs of a
> > Chromebook which has 7 GPIO groups.
> > 
> > Why these groups cannot be defined at compile time (Shortcomings):
> > 
> > 1) We don't know the total GPIO groups.
> > Possible solution: Determine GPIO groups' number at run time and define
> > attributes at run time.
> 
> What is the max number of groups you can ever have?  10?  100?  1000?
> Pick a high number, define them all (macros make this easy), and then
> only enable the ones that you need at runtime.
> 
> > 2) We cannot determine from attribute name that this group will be
> > visible or not as is_visible doesn't provide information about its group
> > name.
> > umode_t (*is_visible)(struct kobject *, struct attribute *, int);
> 
> Look at the attribute pointer.  That's all you care about.  Compare it
> to a real pointer and away you go!

Also remember, each group has a is_visible function, so you know what
group this is implicitly.

thanks,

greg k-h
