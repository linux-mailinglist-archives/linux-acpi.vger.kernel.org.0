Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2511E1C6
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLMKPk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 05:15:40 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42832 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMKPj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 05:15:39 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id fa3bee42b0e7e8f9; Fri, 13 Dec 2019 11:15:37 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v9] software node: add basic tests for property entries
Date:   Fri, 13 Dec 2019 11:15:37 +0100
Message-ID: <1629612.3OA72MvNtE@kreacher>
In-Reply-To: <20191213001829.GG101194@dtor-ws>
References: <201912040922.hUcG8uqP%lkp@intel.com> <12135118.EjhP6glzqA@kreacher> <20191213001829.GG101194@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, December 13, 2019 1:18:29 AM CET Dmitry Torokhov wrote:
> On Wed, Dec 11, 2019 at 11:53:05AM +0100, Rafael J. Wysocki wrote:
> > On Monday, December 9, 2019 9:44:47 AM CET Rafael J. Wysocki wrote:
> > > On Wed, Dec 4, 2019 at 7:53 PM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > This adds tests for creating software nodes with properties supplied by
> > > > PROPERTY_ENTRY_XXX() macros and fetching and validating data from said
> > > > nodes/properties.
> > > >
> > > > We are using KUnit framework for the tests.
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 
> > > Applied (as 5.5 material), thanks!
> > 
> > And dropped again, because 0-day still complains.
> > 
> > I'm going to push the rest of the series to Linus this week.  The last patch
> > can wait, even though it would be good to have it.
> 
> Could you point me to the 0-say compaint for the latest version as I did
> not get it. I am still interested in sorting it all out.
> 

I have forwarded it to you: https://lore.kernel.org/linux-acpi/1860961.FledB3ecnK@kreacher/T/#u



