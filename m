Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63A513BD34
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2020 11:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgAOKPL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jan 2020 05:15:11 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52147 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgAOKPL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2020 05:15:11 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 071a7227e5a6e408; Wed, 15 Jan 2020 11:15:08 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chester Lin <clin@suse.com>
Cc:     "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [RFC PATCH v2 1/3] ACPI / hotplug: Send change events for offline/online requests when eject is triggered
Date:   Wed, 15 Jan 2020 11:15:08 +0100
Message-ID: <1702691.vqsIMzBuNn@kreacher>
In-Reply-To: <20200103043926.31507-2-clin@suse.com>
References: <20200103043926.31507-1-clin@suse.com> <20200103043926.31507-2-clin@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, January 3, 2020 5:40:09 AM CET Chester Lin wrote:
> Here we change offline/online handling in device hotplug by sending change
> events to userland as notification so that userland can have control and
> determine when will be a good time to put them offline/online based on
> current workload. In this approach the real offline/online opertions are
> handed over to userland so that userland can have more time to prepare
> before any device change actually happens.
> 
> All child devices under the ejection target are traversed and notified
> hierarchically based on ACPI namespace in ascending order when an eject
> event happens.
> 
> Signed-off-by: Chester Lin <clin@suse.com>

So you replace the old flow with the new one and make the new one mandatory AFAICS.

Thus if anyone has relied on the old flow, they now need to switch over.

This is unfriendly and generally unwelcome, so please avoid making changes like
that.

Instead, I would consider adding a device attribute to allow user space to
opt in for getting offline notifications for specific individual devices (by
setting that attribute user space would tell the kernel that it wants to
get offline notifications for the device in question and it would take
care of offlining it as needed).



