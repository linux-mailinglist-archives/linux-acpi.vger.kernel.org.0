Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A06367CC
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Nov 2022 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiKWRzs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Nov 2022 12:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbiKWRzq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Nov 2022 12:55:46 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE36BAEA6A
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2022 09:55:44 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q10so1735515qvt.10
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2022 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZGGAbQVRBkDZyExP7ffjlyLb6N0sV9F4cgg4l8gSxE=;
        b=My/je7B5AkyQl5fsdxgrcU4MlCIO0r7BQ5Ticu0quoimRFyd1QFWg1CIRYo2hSlhCk
         gVjIJJSUMGBCSbu4UDXzbQPaiJloUApBWvaqFNa76nYHQxGNxzJWcDLEm0qltzXuuN/Z
         gO+uDnAR3m7NYXWzCuDuYM8LFnvN0Xu6vLCMlAClrlBYpN6lXcqxJLcrsGyjBmH/Sv12
         +4Tfy+Id6dykaHW4e8It4+0URa6BTBpgvGETfgKsz3tVQND5afP3nmgNdrdjI227ASXm
         vr1NQmNHtxvof8mhDMYhIaXb4hON7jWdw6w75cCEJBe1LxtxXk3bYjl3v+s4zDC4Zj8c
         gKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZGGAbQVRBkDZyExP7ffjlyLb6N0sV9F4cgg4l8gSxE=;
        b=FFRBUDu3ivOpzxP74vuNZJeiO8J9ZFOzSECkrulbda0AFv0xw1koNE1UjXdE3sJ/4X
         aLWEhUrdPbzE7Dt5FHQg4ef4Kw9ed9FuSbkomdD8FTZ2/WzLlLkApaTt88XEz0rDgkP5
         jSlpytI7WV2EZ2dKerJZ/TJzZNfJ43F+h+LP0ypDyZc4UUJGliJqY4BpZxLPZy72qyTV
         vEmHxWIz7lJL5da5lC+70KcYp2WrR4gzNSoRZqebrm8tMZsVxQ+ikEaYMA9aqC+FLyzc
         xCl79cFto4QycnANhyHJKTIMMn19r38NsEaSyLlfnxrjHbR1qholnEjN3V2vR3Lgkm5+
         6MHQ==
X-Gm-Message-State: ANoB5pk2snnZVaJ5UetfOTpYcZ0JqaIza3FYBMmUeMDjgstn3RGIV4JQ
        Z/6LFUQ4Ofe2U7kh8WpDOsBlQg==
X-Google-Smtp-Source: AA0mqf6wKiTjKYxvtjsF4TJ4YPeSr0mdEUQ+pw8A+HZdflt1p0dm9sIfWC/e+svu0siqN7xcA8Vb/g==
X-Received: by 2002:a05:6214:209:b0:4bb:6bbd:8c1b with SMTP id i9-20020a056214020900b004bb6bbd8c1bmr9012796qvt.111.1669226143925;
        Wed, 23 Nov 2022 09:55:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b006faaf6dc55asm11988986qkk.22.2022.11.23.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:55:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxtyI-00Afdu-Dk;
        Wed, 23 Nov 2022 13:55:42 -0400
Date:   Wed, 23 Nov 2022 13:55:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Wolfram Sang <wsa@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 3/5] driver core: make struct device_type.uevent() take a
 const *
Message-ID: <Y35enjI+dhhqiG3B@ziepe.ca>
References: <20221123122523.1332370-3-gregkh@linuxfoundation.org>
 <711d5275-7e80-c00d-0cdc-0f3d52175361@gmail.com>
 <Y34hgIW8p1RlQTBB@smile.fi.intel.com>
 <97be39ed-3cea-d55a-caa6-c2652baef399@gmail.com>
 <Y34zyzdbRUdyOSkA@casper.infradead.org>
 <Y34+V2bCDdqujBDk@kroah.com>
 <Y35JfNJDppRp5bLX@ziepe.ca>
 <Y35R+/eQJYI7VaDS@kroah.com>
 <Y35YlI93UBuTfgYy@ziepe.ca>
 <Y35dMIaNYSE0Cykd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35dMIaNYSE0Cykd@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 23, 2022 at 05:49:36PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 23, 2022 at 01:29:56PM -0400, Jason Gunthorpe wrote:
> > #define generic_container_of(in_type, in, out_type, out_member) \
> > 	_Generic(in,                                        \
> >                   const in_type *: ((const out_type *)container_of(in, out_type, out_member)),   \
> >                   in_type *: ((out_type *)container_of(in, out_type, out_member)) \
> > 		  )
> 
> There's a neat trick I found in seqlock.h:
> 
> #define generic_container_of(in_t, in, out_t, m)			\
> 	_Generic(*(in),							\
> 		const in_t: ((const out_t *)container_of(in, out_t, m)), \
> 		in_t: ((out_t *)container_of(in, out_type, m))	\
> 	)
>
> and now it fits in 80 columns ;-)

Aside from less letters, is their another benifit to using *(in) ?

Jason
