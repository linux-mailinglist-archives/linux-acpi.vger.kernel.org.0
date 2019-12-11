Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2532611A94B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2019 11:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfLKKxI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Dec 2019 05:53:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56052 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfLKKxI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Dec 2019 05:53:08 -0500
Received: from 79.184.253.70.ipv4.supernova.orange.pl (79.184.253.70) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id ab16ea88a6a49f12; Wed, 11 Dec 2019 11:53:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v9] software node: add basic tests for property entries
Date:   Wed, 11 Dec 2019 11:53:05 +0100
Message-ID: <12135118.EjhP6glzqA@kreacher>
In-Reply-To: <CAJZ5v0jDmNUqPVWH9XnwEreg=HucbtjWf6LW630iPMtBb9f1Nw@mail.gmail.com>
References: <201912040922.hUcG8uqP%lkp@intel.com> <20191204185315.GM50317@dtor-ws> <CAJZ5v0jDmNUqPVWH9XnwEreg=HucbtjWf6LW630iPMtBb9f1Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, December 9, 2019 9:44:47 AM CET Rafael J. Wysocki wrote:
> On Wed, Dec 4, 2019 at 7:53 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > This adds tests for creating software nodes with properties supplied by
> > PROPERTY_ENTRY_XXX() macros and fetching and validating data from said
> > nodes/properties.
> >
> > We are using KUnit framework for the tests.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Applied (as 5.5 material), thanks!

And dropped again, because 0-day still complains.

I'm going to push the rest of the series to Linus this week.  The last patch
can wait, even though it would be good to have it.

Cheers!



