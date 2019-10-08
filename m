Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F33CF9B3
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJHMZC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Oct 2019 08:25:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730249AbfJHMZC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Oct 2019 08:25:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 232E5B186;
        Tue,  8 Oct 2019 12:25:00 +0000 (UTC)
Date:   Tue, 8 Oct 2019 14:24:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v9 00/12] Device property improvements, add %pfw format
 specifier
Message-ID: <20191008122459.z62tk5xqpqhfifxl@pathway.suse.cz>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu 2019-10-03 15:32:07, Sakari Ailus wrote:
> Hi all,
> 
> This set adds functionality into the device property API (counting a
> node's parents as well as obtaining its name) in order to support printing
> fwnode names using a new conversion specifier "%pfw". The names that are
> produced are equivalent to its OF counterpart "%pOF" on OF systems for the
> two supported modifiers ("f" and "P").
> 
> Printing a node's name is something that's been available on OF for a long
> time and if something is converted to device property API (such as the
> V4L2 fwnode framework) it always got removed of a nice feature that was
> sometimes essential in debugging. With this set, that no longer is the
> case.

The patchset is ready to go upstream from my POV.

Should it go via a tree that maintains the device property API
or via printk.git? Both possibilities work for me.

Best Regards,
Petr
