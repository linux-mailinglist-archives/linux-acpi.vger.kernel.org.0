Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA32BC825
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504979AbfIXMrp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 08:47:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504978AbfIXMro (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 08:47:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4148AAB0;
        Tue, 24 Sep 2019 12:47:41 +0000 (UTC)
Date:   Tue, 24 Sep 2019 14:47:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 12/13] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190924124741.tuqks52bpwheqbwj@pathway.suse.cz>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-13-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918133419.7969-13-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 2019-09-18 16:34:18, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.
> 
> On ACPI based systems the resulting strings look like
> 
> 	\_SB.PCI0.CIO2.port@1.endpoint@0
> 
> where the nodes are separated by a dot (".") and the first three are
> ACPI device nodes and the latter two ACPI data nodes.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
