Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3589C2C4AD4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 23:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKYWcL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 17:32:11 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:53641 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgKYWcL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 17:32:11 -0500
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 2F465200002;
        Wed, 25 Nov 2020 22:32:03 +0000 (UTC)
Message-ID: <2207fea9195877a7ac6d6d203d9f81d07362a80f.camel@hadess.net>
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform
 profile support
From:   Bastien Nocera <hadess@hadess.net>
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Date:   Wed, 25 Nov 2020 23:32:03 +0100
In-Reply-To: <4e82d54f-33c2-e880-c5f8-beb9d3460cdb@lenovo.com>
References: <markpearson@lenovo.com>
         <20201115004402.342838-1-markpearson@lenovo.com>
         <nRyY5CKaU6WrkbMiM25gTT_bJlrQjTY_UCcQkj8ty-2mPEMVZd4BB9KwrRp7z4GaE3TTOFCXuXnt0_7J_Tj50syusBxTmS5yNZAvYX02X74=@protonmail.com>
         <761671b3-ad26-230b-e709-05ce3bd69498@redhat.com>
         <27a41e3d678f9d7fc889a3a77df87f9ed408887d.camel@hadess.net>
         <92a564fa-686f-455d-a0cb-962d4d87a8c7@redhat.com>
         <4e82d54f-33c2-e880-c5f8-beb9d3460cdb@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2020-11-25 at 14:41 -0500, Mark Pearson wrote:
> On 25/11/2020 11:42, Hans de Goede wrote:
> > Hi,
> > 
> > On 11/24/20 4:30 PM, Bastien Nocera wrote:
> > > On Sat, 2020-11-21 at 15:27 +0100, Hans de Goede wrote:
> > > > Hi,
> > > > On 11/20/20 8:50 PM, Barnabás Pőcze wrote:
> > > > > Hi
> > > > > 2020. november 15., vasárnap 1:44 keltezéssel, Mark Pearson
> > > > > írta:
> > > > > 
> > > > Bastien, what do you think about Barnabás' suggestion to always
> > > > have the files present and use poll (POLL_PRI) on it to see
> > > > when
> > > > it changes, listing maybe "none" as available profiles when
> > > > there
> > > > is no provider?
> > > 
> > > Whether the file exists or doesn't, we have ways to monitor it 
> > > appearing or disappearing. I can monitor the directory with
> > > inotify
> > > to see the file appearing or disappearing, or I can monitor the
> > > file with inotify to see whether it changes.
> > 
> > Ok, do you have a preference either way? I personally think having
> > the file only appear if its functional is a bit cleaner. So if it
> > does not matter much for userspace either way then I suggest we go
> > that route.
> > 
> My (limited) vote is having the file appear when the profile is
> loaded 
> seems nicer (and to disappear if the profile is unloaded). No
> profile, 
> no interface just seems elegant.
> 
> I pretty much have v4 of the patches ready to go (I wanted to rebase
> on 
> the update for the palm sensor and finished that today). I'm happy to
> hold off on them until we're ready if that helps. Bastien - let me
> know 
> if it would be useful to have a version to test against to see what
> will 
> work best for you, or if you need something different. Definitely
> want 
> to make sure user space gets the best option as my understanding is 
> changing this later becomes a pain :)

I don't have the hardware. I agree with you that "no profile = no file"
seems cleaner, but whichever is easier for you.

