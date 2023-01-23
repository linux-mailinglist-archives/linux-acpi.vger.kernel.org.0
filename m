Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC167803E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjAWPoU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjAWPoT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:44:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37B8CDEE
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:44:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so8891011wms.2
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EL69+rPnKeG35tCOAhKwCTlgNoHpcrZ2APlPxC5Kf4s=;
        b=ASN/i9xD+3TUCWN1tEycO/CFk1Zsr6bUhPwLBz+rcqvKpImrhvevbMueqPdZKW4r2F
         crJvl9X4O1jz0Obi31lpWPIjqol/AgWYZrNJqMYVDlzqwpnQINDhAzHM0Q7CjjRoG4Ss
         iBDeEREU9l5tCmB1BQsJ46D/Tpt0DdW/biUhm9hlE+NocVX4pzoz7roMYXOlFWH+ekyy
         MCKl2EUbrGHDRjpQpZkl+eR3SJUkNnnUIy0qEPimGWUmk2WnbJqIM9P3zh4m7r2xbUoT
         /z62DybIrHxwsfiRmnZwAvnGHQ1U9TigQqw1zoKBNVWvu87ZiOpYwdji8rsNsPBK/Dgy
         0TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL69+rPnKeG35tCOAhKwCTlgNoHpcrZ2APlPxC5Kf4s=;
        b=P7do29/o2vILP930ZtBxU4mSqI0QCqs5KPlE/2yVQ8GnYexnDP53/r5NWYTVm0hYG1
         TYk++rkqAVEkNIPdjtY2VPqWZnm4nNvU7TE3i3eZ/nVkDxFwvmaVKM18NR58GwUI0PZO
         vSeb+b5eA4/SSXV5uo4AgpYHwRak+vPFrMBvRChCoGWaNxf1U6p6S8+kHvuzqKiznJ51
         P4H5ua/tR9yTvcHSgoi/t/K8bbzvjAN9iihy7fBAGTVfWLb79j8kDW4BbNj8RnvRR9C/
         FeFS5rPwnaNry6AYlKhqs4Utx0IVGOdTSQWY0ST0ZopoJrWAZiar2nXEoMXu03iMoQJ6
         XFXw==
X-Gm-Message-State: AFqh2kr4hc6KYgwDHGGYGpO5CEQBkxmlLw6ohz/p410VT/Nj3HQouraz
        /z5t+8h4L8mobz2A6pbrwv+SeYzMbChQ0g==
X-Google-Smtp-Source: AMrXdXtG5pwf9+pz1eWKwHr3kW/9Br31uwV7Np4Hs5r+bLuuLI3flpKcwFG8kQQHN/UyR32QHBbLoA==
X-Received: by 2002:a05:600c:1e1f:b0:3db:e13:750c with SMTP id ay31-20020a05600c1e1f00b003db0e13750cmr22792736wmb.29.1674488651150;
        Mon, 23 Jan 2023 07:44:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003db11dfc687sm11553878wmo.36.2023.01.23.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:44:10 -0800 (PST)
Date:   Mon, 23 Jan 2023 18:44:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [bug report] arch_topology: Build cacheinfo from primary CPU
Message-ID: <Y86rRxRCbel5xUE0@kadam>
References: <Y86iruJPuwNN7rZw@kili>
 <6fc14182-520b-d3ee-410c-8be3bc98a514@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc14182-520b-d3ee-410c-8be3bc98a514@arm.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 04:14:56PM +0100, Pierre Gondois wrote:
> Hello Dan,
> The 'levels' and 'split_levels' variables are initialized through their
> addresses when necessary, so I believe the warning can be ignored.

I don't understand what "initialized through their addresses when
necessary" means.  If you have CONFIG_ACPI_PPTT turned off as I do then
acpi_get_cache_info() is a no-op so it's not initializing anything.

> 
> If you still want to have the variables initialized, please let me know and I
> will send a patch,

I feel like I have this kind of discussion a lot.  I don't know why
people don't want to initialize their variables to zero.

1) It doesn't affect runtime on modern distros because they use the
   CONFIG_ option to zero stack variables.

2) If they don't then syzbot will detect it at runtime.  It will probably
   take a year or two.  That will set off a bunch of emails.  Meanwhile
   you will have joined an exciting new start up and won't be around.
   No one else will remember how this code works.

regards,
dan carpenter


