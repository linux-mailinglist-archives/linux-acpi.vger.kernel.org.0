Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1939CEBB3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2019 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfJGSYW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Oct 2019 14:24:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbfJGSYV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Oct 2019 14:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570472660;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCQBbH69Pg1ZkWDiANjXEs7D77CgeYE54SQ2IQO4wnE=;
        b=as1shgEVyfW80E+FyuBBhml/4IPmzY6C1o7qN1rq0In3bsYU25sO1Liv3HUEeSN8opYVI6
        3xuxGUGqo9raOeWICrhvgwMbOV6VYsxZ/NBg5NEyjDw8CbiXp8kHY4mnYEsr4KjdVxp3bc
        EI9XkLsHSaKtxv3JK+Z1NLULpw3mjNQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-mMkw9j3_MMe2-3gTTqxIdw-1; Mon, 07 Oct 2019 14:24:19 -0400
Received: by mail-io1-f71.google.com with SMTP id u18so28186180ioc.4
        for <linux-acpi@vger.kernel.org>; Mon, 07 Oct 2019 11:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eCQBbH69Pg1ZkWDiANjXEs7D77CgeYE54SQ2IQO4wnE=;
        b=D28hgKtVEN5SfTIzaBPtfL9gNYTA5L/VvcCZTemOwCjhGNS1nRYlPmq08YCRvCr1VR
         QSoERHnTscb3MhhQ4dPIlu4Qn9tAZ0/5GEUfVu+B3bA4FRfgVCERrQs8DvLP4fiOJgLt
         Iv27GHAfj4My8Fn7DYBVUosE2NHlkE6n9/cK5faRY3VbOXBEtUzdTBwR0hwJbPoWN1nl
         syjQTg20IwAlyAC544aFyfvSn3pzcbh26cNLKLVtbhgGOL/Rn0UyyJV/BmI6ZfXE4DdK
         145ueeAAFBibE1vXujEa1lgrNj2BDMyJQzQewKYpTrFLVbJGF7d/cjkPXiFr+73a9+hu
         hGeA==
X-Gm-Message-State: APjAAAUkfwqXXbKTuhXNTh3hnw28fTem6KnzxOSsHBQlKSW81OHqnRtN
        FMityJyB0Zw3whF6NzLH/FHtoxsLekcb5wdqqy7mClZi4jvhJRlLLcf2BwSN5iVvr1qVbbYUDZ7
        cWJZGj4/bESIiwPHzeYxE7Q==
X-Received: by 2002:a92:9cca:: with SMTP id x71mr15879282ill.245.1570472658214;
        Mon, 07 Oct 2019 11:24:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRjcepKCt0gHU4J1fh/VS38XxOBSx6x1eDJ//ttvcWAF97bQNybglqC62SyFGnxx6CS0fwfw==
X-Received: by 2002:a92:9cca:: with SMTP id x71mr15879262ill.245.1570472657939;
        Mon, 07 Oct 2019 11:24:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l13sm7026832ilq.56.2019.10.07.11.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 11:24:16 -0700 (PDT)
Date:   Mon, 7 Oct 2019 11:24:15 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191007182415.ftpojfdluoun34xm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
 <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: mMkw9j3_MMe2-3gTTqxIdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue Sep 24 19, Andy Shevchenko wrote:
>Since we have a generic helper, drop custom implementation in the driver.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

