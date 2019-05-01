Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D2A106DB
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEAKPK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 06:15:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64696 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEAKPK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 May 2019 06:15:10 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 16ecf9d589608daa; Wed, 1 May 2019 12:15:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
Date:   Wed, 01 May 2019 12:15:07 +0200
Message-ID: <3825811.MXkekUSqSZ@kreacher>
In-Reply-To: <20190425152034.u4q6wjhm3yfhbnzp@mail.google.com>
References: <20190424175306.25880-1-changbin.du@gmail.com> <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com> <20190425152034.u4q6wjhm3yfhbnzp@mail.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, April 25, 2019 5:20:35 PM CEST Changbin Du wrote:
> On Thu, Apr 25, 2019 at 10:44:14AM +0200, Rafael J. Wysocki wrote:
> > .On Wed, Apr 24, 2019 at 7:54 PM Changbin Du <changbin.du@gmail.com> wrote:
> > >
> > > Hi All,
> > > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > > from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> > > reST format in this serias.
> > >
> > > The hieararchy of ACPI docs are based on Corbet's suggestion:
> > > https://lkml.org/lkml/2019/4/3/1047
> > > I did some adjustment according to the content and finally they are placed as:
> > > Documentation/firmware-guide/acpi/
> > 
> > I'd like to queue up this series, but it is missing a patch to create
> > Documentation/firmware-guide/acpi/index.rst.
> > 
> > Care to provide one?
> oops, the first patch is missed. Let me add it next.

I've picked up the first patch from the v6 and applied this series on top of it.

 Thanks!



