Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6505957F15
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfF0JSH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 05:18:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40125 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JSH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 05:18:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id e8so1538155otl.7
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jun 2019 02:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYlPTdc+nSbVejl57wVgudRwjNsy7DxeSFbXCfQXb/Y=;
        b=loDkMPMFotVEAfQsOU8zapBytuqZo1X8Cy0wzX5UhYuedM1ce97kQUZfwXlr6LrX+Q
         O7L2t5urgO3nRrPqTqN8X9Qn9Q5uwDKLr0DSTTwz8HSQ9zNY/rTK1vJO4+0zQo4P2tR4
         Gn8RkSwgLa9Oq5bSEnvw8TdGbr77KiFrViQXI+fh6vbJfahsNwy0lzYRo0z5NB9Rs1R5
         TdXN4F0Jvt3A0Rf4UmI7LqhwCOJ+Vs6Ivxo7lsqnABOQzkyh6AzGUtMiMDiCwjynyrY+
         WX5FqgqT5s4IFHRl2XSC9sh2n4UFBDUeUVsR5V0Rf6km96V64kVAMf5absvinHf4gCsf
         w3eg==
X-Gm-Message-State: APjAAAXD+McHa4CLB3fUbu7C7auBEswvb38FQZBaSOc/too1on6VtcXj
        yDdKtt0znX53KavxcUvqWODXeu5zbPQB4dqb6Bo=
X-Google-Smtp-Source: APXvYqzrPV3cRJWCnDDd+ELRt78GEL9XyT/gQ4rbxjSThLFSFEzuf7U07F+wz0AhlBJcJNQJwPNp7QwOJKyhDSaQ0WI=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr2402578oto.118.1561627086878;
 Thu, 27 Jun 2019 02:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com> <20190627001530.GG527@kroah.com>
In-Reply-To: <20190627001530.GG527@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 11:17:55 +0200
Message-ID: <CAJZ5v0g8or=OrEYBPE4K7k6P1ymAHOdwFaqZE9-Lr8eVp0hubg@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Add new array helper
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 27, 2019 at 2:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 26, 2019 at 04:36:10PM +0100, Charles Keepax wrote:
> > It is fairly common to want to read an integer array property
> > that is composed of an unknown number of fixed size integer
> > groups. For example, say each group consists of three values
> > which correspond to the settings for one input on the device
> > and the driver supports several chips with different numbers
> > of inputs.
> >
> > Add a new helper function to provide this functionality, it
> > differs for the existing helpers in that it allows reading a
> > smaller number of values than the full array size and checks
> > that the number of values read is a multiple of the group size.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/base/property.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |  2 ++
> >  2 files changed, 50 insertions(+)
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Well, I'm kind of not convinced about this one.

More comments in direct reply to the patch message.
