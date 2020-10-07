Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D35285E89
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Oct 2020 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgJGL6Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 07:58:25 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35804 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJGL6Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2020 07:58:25 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id BF1DF3B64F5;
        Wed,  7 Oct 2020 11:52:15 +0000 (UTC)
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3A8A3100012;
        Wed,  7 Oct 2020 11:51:47 +0000 (UTC)
Message-ID: <85a36eb58cb9774f1907582dfc75295ed847200c.camel@hadess.net>
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
From:   Bastien Nocera <hadess@hadess.net>
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>
Date:   Wed, 07 Oct 2020 13:51:47 +0200
In-Reply-To: <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
         <20201003131938.9426-2-hdegoede@redhat.com>
         <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.0 (3.38.0-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-10-05 at 12:58 +0000, Limonciello, Mario wrote:
> > On modern systems CPU/GPU/... performance is often dynamically
> > configurable
> > in the form of e.g. variable clock-speeds and TPD. The performance
> > is often
> > automatically adjusted to the load by some automatic-mechanism
> > (which may
> > very well live outside the kernel).
> > 
> > These auto performance-adjustment mechanisms often can be
> > configured with
> > one of several performance-profiles, with either a bias towards
> > low-power
> > consumption (and cool and quiet) or towards performance (and higher
> > power
> > consumption and thermals).
> > 
> > Introduce a new performance_profile class/sysfs API which offers a
> > generic
> > API for selecting the performance-profile of these automatic-
> > mechanisms.
> > 
> 
> If introducing an API for this - let me ask the question, why even let each
> driver offer a class interface and userspace need to change "each" driver's
> performance setting?
> 
> I would think that you could just offer something kernel-wide like
> /sys/power/performance-profile
> 
> Userspace can read and write to a single file.  All drivers can get notified
> on this sysfs file changing.
> 
> The systems that react in firmware (such as the two that prompted
> this discussion) can change at that time.  It leaves the possibility for a
> more open kernel implementation that can do the same thing though too by
> directly modifying device registers instead of ACPI devices.

The problem, as I've mentioned in previous discussions we had about
this, is that, as you've seen in replies to this mail, this would
suddenly be making the kernel apply policy.

There's going to be pushback as soon as policy is enacted in the
kernel, and you take away the different knobs for individual components
(or you can control them centrally as well as individually). As much as
I hate the quantity of knobs[1], I don't think that trying to reduce
the number of knobs in the kernel is a good use of our time, and easier
to enact, coordinated with design targets, in user-space.

Unless you can think of a way to implement this kernel wide setting
without adding one more exponent on the number of possibilities for the
testing matrix, I'll +1 Hans' original API.

Cheers

[1]: https://ometer.com/preferences.html

