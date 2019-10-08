Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28ECCCF8EC
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 13:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHLx2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Oct 2019 07:53:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:60546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbfJHLx2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Oct 2019 07:53:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31DDAB293;
        Tue,  8 Oct 2019 11:53:26 +0000 (UTC)
Date:   Tue, 8 Oct 2019 13:53:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v9 07/12] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
Message-ID: <20191008115323.qgy5gq3oipcspfsz@pathway.suse.cz>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
 <20191003123219.11237-8-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003123219.11237-8-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu 2019-10-03 15:32:14, Sakari Ailus wrote:
> %pS and %ps are now the preferred conversion specifiers to print function
> names. The functionality is equivalent; remove the old, deprecated %pF
> and %pf support.
> 
> Depends-on: commit 2d44d165e939 ("scsi: lpfc: Convert existing %pf users to %ps")
> Depends-on: commit b295c3e39c13 ("tools lib traceevent: Convert remaining %p[fF] users to %p[sS]")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
