Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2EABC42
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391203AbfIFPXk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 11:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfIFPXk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Sep 2019 11:23:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CEA13064FB0;
        Fri,  6 Sep 2019 15:23:40 +0000 (UTC)
Received: from ovpn-112-22.rdu2.redhat.com (ovpn-112-22.rdu2.redhat.com [10.10.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 406945C1D8;
        Fri,  6 Sep 2019 15:23:36 +0000 (UTC)
Message-ID: <717c9727a713aff7a3415bf0f4ea776de90c37bf.camel@redhat.com>
Subject: Re: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through
 functionality
From:   Dan Williams <dcbw@redhat.com>
To:     =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Charles.Hyde@dellteam.com
Cc:     oliver@neukum.org, rjw@rjwysocki.net, lenb@kernel.org,
        Mario.Limonciello@dell.com, chip.programmer@gmail.com,
        nic_swsd@realtek.com, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 06 Sep 2019 10:23:36 -0500
In-Reply-To: <874l1pua6n.fsf@miraculix.mork.no>
References: <1567717304186.90134@Dellteam.com>
         <874l1pua6n.fsf@miraculix.mork.no>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 06 Sep 2019 15:23:40 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 2019-09-06 at 09:59 +0200, Bjørn Mork wrote:
> <Charles.Hyde@dellteam.com> writes:
> 
> > +	if (strstr(dev->udev->product, "D6000")) {
> 
> Huh? Can you please test that on all USB devices ever made?

Yeah. Can't VID/PID be used as the filter here instead?

Dan

