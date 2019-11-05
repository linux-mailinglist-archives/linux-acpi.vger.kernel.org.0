Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4419DF0A14
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 00:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfKEXLe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Nov 2019 18:11:34 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55383 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKEXLe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2019 18:11:34 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 050ac5c5179a3f27; Wed, 6 Nov 2019 00:11:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: intel_soc_pmic_crc: Add "cht_crystal_cove_pmic" cell to CHT cells
Date:   Wed, 06 Nov 2019 00:11:32 +0100
Message-ID: <9960583.3dFhK665ib@kreacher>
In-Reply-To: <20191101090111.GG5700@dell>
References: <20191024213827.144974-1-hdegoede@redhat.com> <20191024213827.144974-5-hdegoede@redhat.com> <20191101090111.GG5700@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, November 1, 2019 10:01:11 AM CET Lee Jones wrote:
> On Thu, 24 Oct 2019, Hans de Goede wrote:
> 
> > Add a "cht_crystal_cove_pmic" cell to the cells for the Cherry Trail
> > variant of the Crystal Cove PMIC. Adding this cell enables / hooks-up
> > the new Cherry Trail Crystal Cove PMIC OpRegion driver.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/mfd/intel_soc_pmic_crc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Applied, thanks.

OK, I need to drop it then, thanks!



