Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181572C2B5A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Nov 2020 16:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbgKXPa5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Nov 2020 10:30:57 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:60725 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389670AbgKXPa4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2020 10:30:56 -0500
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6969C200010;
        Tue, 24 Nov 2020 15:30:51 +0000 (UTC)
Message-ID: <27a41e3d678f9d7fc889a3a77df87f9ed408887d.camel@hadess.net>
Subject: Re: [PATCH v3] ACPI: platform-profile: Add platform profile support
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Date:   Tue, 24 Nov 2020 16:30:50 +0100
In-Reply-To: <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
References: <markpearson@lenovo.com>
         <20201115004402.342838-1-markpearson@lenovo.com>
         <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
         <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 2020-11-21 at 15:27 +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/20/20 8:50 PM, Barnabás Pőcze wrote:
> > Hi
> > 
> > 
> > 2020. november 15., vasárnap 1:44 keltezéssel, Mark Pearson írta:
> > 
> > > [...]
> > > +int platform_profile_register(struct platform_profile_handler
> > > *pprof)
> > > +{
> > > +       mutex_lock(&profile_lock);
> > > +       /* We can only have one active profile */
> > > +       if (cur_profile) {
> > > +               mutex_unlock(&profile_lock);
> > > +               return -EEXIST;
> > > +       }
> > > +
> > > +       cur_profile = pprof;
> > > +       mutex_unlock(&profile_lock);
> > > +       return sysfs_create_group(acpi_kobj,
> > > &platform_profile_group);
> > > +}
> > > +EXPORT_SYMBOL_GPL(platform_profile_register);
> > > +
> > > +int platform_profile_unregister(void)
> > > +{
> > > +       mutex_lock(&profile_lock);
> > > +       sysfs_remove_group(acpi_kobj, &platform_profile_group);
> > > +       cur_profile = NULL;
> > > +       mutex_unlock(&profile_lock);
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(platform_profile_unregister);
> > > [...]
> > 
> > 
> > I just realized that the sysfs attributes are only created if a
> > profile provider
> > is registered, and it is removed when the provide unregisters
> > itself. I believe
> > it would be easier for system daemons if those attributes existed
> > from module load
> > to module unload since they can just just open the file and watch
> > it using poll,
> > select, etc. If it goes away when the provider unregisters itself,
> > then I believe
> > a more complicated mechanism (like inotify) would need to be
> > implemented in the
> > daemons to be notified when a new provider is registered. Thus my
> > suggestion
> > for the next iteration is to create the sysfs attributes on module
> > load,
> > and delete them on unload.
> > 
> > What do you think?
> 
> Actually I asked Mark to move this to the register / unregister time
> since
> having a non functioning files in sysfs is a bit weird.
> 
> You make a good point about userspace having trouble figuring when
> this will
> show up though (I'm not worried about removal that will normally
> never happen).
> 
> I would expect all modules to be loaded before any interested daemons
> load,
> but that is an assumption and I must admit that that is a bit racy.
> 
> Bastien, what do you think about Barnabás' suggestion to always have
> the
> files present and use poll (POLL_PRI) on it to see when it changes,
> listing
> maybe "none" as available profiles when there is no provider?

Whether the file exists or doesn't, we have ways to monitor it
appearing or disappearing. I can monitor the directory with inotify to
see the file appearing or disappearing, or I can monitor the file with
inotify to see whether it changes. But that doesn't solve the
challenges from user-space.

How do I know whether the computer will have this facility at any
point? Is "none" a placeholder, or a definite answer as to whether the
computer will have support for "platform profile"?

How am I supposed to handle fallbacks, eg. how can I offer support for,
say, changing the "energy performance preference" from the Intel p-
state driver if ACPI platform profile isn't available?

I'm fine with throwing more code at fixing that race, so whatever's
easier for you, it'll be a pain for user-space either way.

