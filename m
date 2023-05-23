Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84370DDB4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjEWNlP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 23 May 2023 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjEWNlM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 09:41:12 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE57E9;
        Tue, 23 May 2023 06:41:07 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96f44435d92so107511266b.0;
        Tue, 23 May 2023 06:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684849266; x=1687441266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmH/9bKI4cSfUn4OM8Z9tQmyqWySWc5zYTh1Xi0QWt8=;
        b=Tc/l10pyCVXRp0hRE2NXL7ZfuwQhnv0i/EEQ9LlZ6mMknE+1Yexo1LqY7z2+551HHq
         1mKiSD6/zHgC1MYb+3YUmRubipA0K0LvHvKzJaDTP+6pYAexz1hI01ziG5VeNoENbr6P
         SvfYJoq2qiQY19nrxVorWmZiWxZFxy/SYVxX1fAvna6UHlUhH6YxEjBUVvDrsc9Ynyhw
         9l7KdWDmURGR+mVotya86ZSn8LT6KG/OCp/v+n5uwxc3L2eGFA7RBJgTdD9zwvNQIY5p
         g4sCu4qz5M/X4lraYepnrpolsAhoCwOWV7t10wD3dSmDwGXD+mkRrLVuAFzYcVs8zzLe
         OrJg==
X-Gm-Message-State: AC+VfDzGEdIg5+is4xMVEYQjgb/LH+FYqHW36IRxw4jKcWbG3LM1JPZT
        pmEh9EPy3i/C/78YPOhVflw6AOyrMV9v2fQfl1A=
X-Google-Smtp-Source: ACHHUZ6o3djYydyggsYDtsgHPo9BWG4uSq0oC7FDBq0po2suy/16kphlBF/EQixvmzI3Ehfnn4CvhhAgzLz8e62lmqU=
X-Received: by 2002:a17:906:d3:b0:94f:66af:b1f7 with SMTP id
 19-20020a17090600d300b0094f66afb1f7mr12269066eji.1.1684849265896; Tue, 23 May
 2023 06:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com> <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
 <ZGNn9jOWmh0/aEOW@kekkonen.localdomain> <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
 <ZGuYHGMQBzBi4myq@kekkonen.localdomain> <CAJZ5v0hW-JewnYP48sowLmi7=v00EBWJLLR-8mWBK8-DOeC=uA@mail.gmail.com>
 <ZGvPzfnr7CMjcjdY@kekkonen.localdomain> <CAJZ5v0isDNDxD-xAxdHiuZZAKPf6r-axs+aC09YGAyO-ow9o0g@mail.gmail.com>
 <ZGym20IJEPytGqXI@kekkonen.localdomain>
In-Reply-To: <ZGym20IJEPytGqXI@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 15:40:54 +0200
Message-ID: <CAJZ5v0jWvbgBjXsgCB6oC_c_xudgVVNrKEtmQY_Y5V=-0jjc8Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] ACPI: property: Parse data node string
 references in properties
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

On Tue, May 23, 2023 at 1:43 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Tue, May 23, 2023 at 01:21:12PM +0200, Rafael J. Wysocki wrote:
> > On Mon, May 22, 2023 at 10:35 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Mon, May 22, 2023 at 06:38:37PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, May 22, 2023 at 6:28 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:

[cut]

> > > >
> > > > Also I'm kind of wondering about the "reference with arguments" part
> > > > which seems to work differently depending on whether the reference is
> > > > represented by a string or by a reference object.
> > >
> > > Yes. With (device) reference objects, it is possible currently to refer to
> > > subnodes with the _DSD data extension child names of those nodes. This is
> > > not done with string references as 1) any node can already be referenced so
> > > there's no need to and 2) as node references are strings already, it's not
> > > possible to distinguish node string references from _DSD data node names.
> > > E.g.
> > >
> > >         "\\_SB.I2C0.LED0", "LED1"
> > >
> > >                            ^ ACPI object name or _DSD data node name?
> > >
> >
> > Has this behavior been documented anywhere?  Or is there any
> > expectation to see anything like this shipping in production platform
> > firmware?
>
> Good question. Support for this was added by commit 4eb0c3bf5ee52f . AFAIR
> it was intended to use this in DisCo for Imaging but after review (in a
> rather liberal sense of the term) it was decided to use string-only
> references, as in this patch.

It looks like this is sort of a placeholder then.

> I'm not aware of anyone needing this. They've been there for about five
> years but I'd guess someone would complain if it stops working for them.

It is also quite straightforward to restore if need be.

> >
> > If any of the above isn't the case, I would be inclined to simply
> > remove this special case and make both the "object reference" and
> > "string" cases work in the same way and if someone needs to refer to a
> > data node, they will just need to use a string (in which case it will
> > be the only option).
>
> Works for me.

OK, I'll make this change then.
