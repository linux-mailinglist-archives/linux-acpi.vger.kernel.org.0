Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51B18B34C
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Mar 2020 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSMWU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Mar 2020 08:22:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62186 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgCSMWU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2020 08:22:20 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id ac0ec80de060ce45; Thu, 19 Mar 2020 13:22:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86: ignore unspecified bit positions in the ACPI global lock field
Date:   Thu, 19 Mar 2020 13:22:18 +0100
Message-ID: <21714545.r8kEu0rk5n@kreacher>
In-Reply-To: <nycvar.YFH.7.76.2003191136480.30451@n3.vanv.qr>
References: <20200305122425.32223-1-jengelh@inai.de> <2030043.rEjxodZhqh@kreacher> <nycvar.YFH.7.76.2003191136480.30451@n3.vanv.qr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, March 19, 2020 11:46:13 AM CET Jan Engelhardt wrote:
> 
> On Saturday 2020-03-14 10:46, Rafael J. Wysocki wrote:
> >On Thursday, March 5, 2020 1:24:25 PM CET Jan Engelhardt wrote:
> >> The value in "new" is constructed from "old" such that all bits defined
> >> as reserved by the ACPI spec[1] are left untouched. But if those bits
> >> do not happen to be all zero, "new < 3" will not evaluate to true.
> >> 
> >> The firmware of the laptop(s) Medion MD63490 / Akoya P15648 comes with
> >> garbage inside the "FACS" ACPI table. The starting value is
> >> old=0x4944454d, therefore new=0x4944454e, which is >= 3. Mask off
> >> the reserved bits.
> >> 
> >> -	return (new < 3) ? -1 : 0;
> >> +	return ((new & 0x3) < 3) ? -1 : 0;
> >
> >Applied as 5.7 material, thanks!
> 
> Would it make sense to funnel this into the upcoming 5.6?
> 

It's been marked for -stable, so it will get into 5.6.y early.

Hopefully, it will get some extra test coverage before that.




