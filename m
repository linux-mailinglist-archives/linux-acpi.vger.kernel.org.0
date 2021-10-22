Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C081F437B80
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhJVRMC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 13:12:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhJVRMB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 13:12:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59FF61063;
        Fri, 22 Oct 2021 10:09:43 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D0D3F73D;
        Fri, 22 Oct 2021 10:09:42 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:09:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 00/14] mailbox: pcc: Add support for PCCT extended PCC
 subspaces
Message-ID: <20211022170939.5nld2aqhkf7jhhft@bogus>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
 <20211011100949.4ck26vos5apts45e@bogus>
 <20211021165439.2cgyjjm5bwb6ydbv@bogus>
 <CABb+yY1xtjnstr432VLk+geuycKWq0BxAoCL7-eN+9wvVZ=t2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1xtjnstr432VLk+geuycKWq0BxAoCL7-eN+9wvVZ=t2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 10:05:52AM -0500, Jassi Brar wrote:
> On Thu, Oct 21, 2021 at 11:54 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Hi Jassi,
> >
> > Gentle ping!
> >
> I'll pick them.
> 
> thanks.

Thanks, you can drop 02/14. I will ask Rafael you pick that up once he is
happy with it.

-- 
Regards,
Sudeep
