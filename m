Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6411F6035D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGEJtf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 05:49:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54591 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfGEJtf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 05:49:35 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 981521a9cf49529e; Fri, 5 Jul 2019 11:49:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] ACPI: PM: Avoid evaluating _PS3 on transitions from D3hot to D3cold
Date:   Fri, 05 Jul 2019 11:49:33 +0200
Message-ID: <2041167.rQhDGEAjgP@kreacher>
In-Reply-To: <20190625141116.GI2640@lahna.fi.intel.com>
References: <10419005.Mb09WM6RCc@kreacher> <3012059.oderKuhLE3@kreacher> <20190625141116.GI2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, June 25, 2019 4:11:16 PM CEST Mika Westerberg wrote:
> On Tue, Jun 25, 2019 at 02:04:45PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If the power state of a device with ACPI PM is changed from D3hot to
> > D3cold, it merely is a matter of dropping references to additional
> > power resources (specifically, those in the list returned by _PR3),
> > and the _PS3 method should not be invoked for the device then (as
> > it has already been evaluated during the previous transition to
> > D3hot).
> > 
> > Fixes: 20dacb71ad28 (ACPI / PM: Rework device power management to follow ACPI 6)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

Thanks!

I've queued this one and the [2/2] with your tag for 5.3.




