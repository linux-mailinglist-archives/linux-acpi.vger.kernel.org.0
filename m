Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C66089B
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfGEPCl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 11:02:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41136 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGEPCl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 11:02:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id 62so6534357lfa.8;
        Fri, 05 Jul 2019 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEDcm+IMzdH45vWKat38tOP6YtE82uRu/Nk82XO3Gqc=;
        b=iJcJXmB5wQwsHy7K+5FKnawavg8Vjb7KBII9CyBGGAGolFGWLmi693+1tRqJK0iza+
         Vax3sfK3ogtihSJZN8rkQ8xF62RwdPkTPNnmIYall/HCRNgX/hSQPpMUPNyc7SR9cjV8
         w4UNSfaeClgSjE2RoYDzRdHEsKTGJFGbllOMrS7YKUHFIOmPahUxNqmq1wXTMnJlKg0T
         mmRULlAmjKi58Kl294M68uDdva31t+w1vYZm00QyRnWHUgv/EeM+sCZcLt6Ol60G/nQl
         mMGHeE3qVPZXRfUEGul+PTXI1kPmIEjevh2ep+DvrwzRGLtAZDMiaXsiHMKqo14XS/Ih
         MW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEDcm+IMzdH45vWKat38tOP6YtE82uRu/Nk82XO3Gqc=;
        b=XyHk7f2CYI9p8xdIFXepRka38RRhhP84k3/x4ACAj4nMDm/xxb6wWalhTDDtQc4OlW
         b0t+tzmR8QM9L4GXuTtK8Mc/gSP1/LLq0AzDmQcjsSdjhPCM4EHVWifjE7WtdjaJrdUB
         NF9Ds7T3VNtZhY309vEZa7T1qhbaVPIkg3lkYPEdFRPU/jqc1vMRL+1uGctyJtb3ZAAc
         sR2SFf8JTB5HfP4UCbQoo5LiU9nxycQdinBu7vs0pIayDT9ATxi13L7GQt2plePoJSuw
         Sf6n2Mba7a1hp+MQVHHCckivdCaXzQoOCabVlFcH9PEhbm5UXV6FVTosnlKGnARlAWlI
         mIFw==
X-Gm-Message-State: APjAAAVEJcvDQOyRIetk9dDcqJ+i/A6w1vkGNgjVADiE/H6v1tEAWlxy
        23vx4l90uPcBNYOpCzbyPRdRF6DyeQVrUBUcK5ppnG1dFSQ=
X-Google-Smtp-Source: APXvYqwVIcoJd9kDvRk37mrrvlpvYlJyK/L+Hv+l55llVIMFAR2Sz0JgXs++W+e3+31hnuyx2k3b7CXmnW4BdGM25nM=
X-Received: by 2002:a19:7509:: with SMTP id y9mr2256015lfe.117.1562338959781;
 Fri, 05 Jul 2019 08:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-8-mika.westerberg@linux.intel.com> <CA+CmpXsak9Rvkq_RNzoxRecMercUPKqdK+KzbHv_fJC59inaHA@mail.gmail.com>
 <20190705145106.GA2640@lahna.fi.intel.com>
In-Reply-To: <20190705145106.GA2640@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 5 Jul 2019 18:02:23 +0300
Message-ID: <CA+CmpXu27CfWeEN2F6YrtVzHTQtas6KyTk6dz4jaeo8LmckHWQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] thunderbolt: Add support for Intel Ice Lake
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org,
        Raanan Avargil <raanan.avargil@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 5, 2019 at 5:51 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> > > +static int nhi_suspend_power_down(struct tb *tb)
> > > +{
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * If there is no device connected we need to perform an additional
> > > +        * handshake through LC mailbox and force power down before
> > > +        * entering D3.
> > > +        */
> > > +       ret = device_for_each_child(&tb->root_switch->dev, NULL,
> > > +                                   nhi_device_connected);
> > > +       if (!ret) {
> > > +               lc_mailbox_cmd(tb->nhi, LC_PREPARE_FOR_RESET);
> > > +               ret = lc_mailbox_cmd_complete(tb->nhi,
> > > +                                             LC_MAILBOX_TIMEOUT);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               return nhi_power_down(tb->nhi);
> >
> > Just to be sure: unforce power is done only if no device is connected?
> > My understanding of the comment above was that unforce power should be done
> > anyway (so it should be outside of this if block), and the difference between
> > the cases is only about the additional LC mailbox message. I guess I misread it.
>
> nhi_power_down() should be only called if no device was connected so it
> should be in correct place. I can try to clarify the comment a bit,
> though.

Maybe adding the word "both" ("to perform both an additional") will make it
clearer. Maybe removing the "additional" (which to my ears sounds like "an
additional operation besides the normal one, to unforce power") is enough.
Again, your call. I'm not sure it's strictly needed, maybe it's just me.

Thanks!
