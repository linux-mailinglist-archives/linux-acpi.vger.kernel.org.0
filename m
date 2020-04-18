Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E66B1AF2FA
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Apr 2020 20:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDRSAP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Apr 2020 14:00:15 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36043 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726089AbgDRSAP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Apr 2020 14:00:15 -0400
Received: (qmail 2621 invoked by uid 500); 18 Apr 2020 14:00:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2020 14:00:14 -0400
Date:   Sat, 18 Apr 2020 14:00:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
In-Reply-To: <5673945.BT02kTCndr@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004181356070.2069-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 18 Apr 2020, Rafael J. Wysocki wrote:

> Hi,
> 
> This is an update including some fixes and extra patches based on the
> continuation of the discussion [1].

I haven't checked the updates in detail yet.  However, it seems that 
dev_pm_skip_suspend() and dev_pm_skip_resume() should be EXPORTed, 
since they are intended to be used by subsystems, which may be in 
modules.

Alan Stern

