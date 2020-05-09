Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF651CBFB7
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgEIJPe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 May 2020 05:15:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56770 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgEIJPe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 May 2020 05:15:34 -0400
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 5c78a43c372a5eca; Sat, 9 May 2020 11:15:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mattia Dongili <malattia@linux.it>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.co>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dominik Mierzejewski <dominik@greysector.net>,
        William Bader <williambader@hotmail.com>
Subject: Re: [PATCH 1/2] [sony-laptop] SNC calls should handle BUFFER types
Date:   Sat, 09 May 2020 11:15:31 +0200
Message-ID: <2337210.yqbmfTWyIV@kreacher>
In-Reply-To: <CAHp75Ve--kecWYufUiXUxUZM=tL3NgKtDNf6Ny4ds8GJVz_0pA@mail.gmail.com>
References: <20200505111810.65586-1-malattia@linux.it> <20200505111810.65586-2-malattia@linux.it> <CAHp75Ve--kecWYufUiXUxUZM=tL3NgKtDNf6Ny4ds8GJVz_0pA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, May 5, 2020 2:27:15 PM CEST Andy Shevchenko wrote:
> +Cc ACPI(CA) people
> 
> On Tue, May 5, 2020 at 1:16 PM <malattia@linux.it> wrote:
> > After commit 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> > objects for ASL create_field() operator") ACPICA creates buffers even
> > when new fields are small enough to fit into an integer.
> 
> > Many SNC calls counted on the old behaviour.
> 
> Rafael, Erik, is it correct behaviour from ACPICA p.o.v. nowadays or
> should be fixed rather there?

The new behavior is correct and it is needed to avoid other failures elsewhere.

Unfortunately, all of the call sites assuming that the conversion will happen
need to be fixed.

Cheers!



