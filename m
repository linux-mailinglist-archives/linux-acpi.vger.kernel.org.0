Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC39D7E8F
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 20:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfJOSMO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 14:12:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36660 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfJOSMO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2019 14:12:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so12988151pfr.3;
        Tue, 15 Oct 2019 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KuukuTWbxW1aKTlRMsfLhvtKo7CX3Gxi82La0Dsuvgo=;
        b=IaibyWK0hkpu/1WulVmWkkC50hm3lfW/u+9XVuH7N+Wlz5z9VO1gid5whtllsBMnRN
         g2OZBdq3xNAuMg5DIFhb3yh2XrIf2fumu6USUSjWOHGF/na1MQW7LDeBCkinZ7Pz72ZQ
         kfyGB3oNHkQcWqTeJDnXmpLMDsfyx+sxbm+X6CSPQJpcPfnngZRQrFt6S3kPd+xBoo7M
         WT6D5gSQq/U6eD/eb73XtcSqJ4rYM0VWUQSgOJ03A3p2yYrJzHaO2AX95Fo1yTgK1DTX
         M6rgA4ext6K6MvssN/VQFD2u142zC88tI66Y+wXLYV2pnaFvwrW5nxt1L5itXXtU1T4K
         DBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KuukuTWbxW1aKTlRMsfLhvtKo7CX3Gxi82La0Dsuvgo=;
        b=ol1l3g9Rd2QNXHaUHF3eXIoBa0KydhvneB+IN4mKFbXxc+KjFH5YvXPpDcHRXF8dtW
         TwIx4t2cxq2qurvI4eefhf011Hkf7xd5RWFnFxlQu4e9NMZBx1oepezrQvia46Et3/+i
         C2DPyN/bGpjx7IymVmrqIl6KVhVJg+7uWDM6aQmM475+bhYIYpbf44/JQPI/UV7jgyK7
         LZK5RoCn3wNsRwoRDM2Qxw9zPg9/P6xOAiF8HK/7qcj+Sc2+5LbhPND56RUncpks2U/n
         HMCNJzeqQ0q44zUCqwbYKAm2bsiY/j54y2nhyb0cxqQkEiTXoF/WM91B97HLuz/HbJhq
         Rjpg==
X-Gm-Message-State: APjAAAVZpcRNPZyErYfa/kaCYboBodzZtRvg2t3y7zT38priQJj8nu2I
        f5lASKk9wRYpddati8NxBYI=
X-Google-Smtp-Source: APXvYqxQK6yiglokN2VdWDcz64cbE9nL246TYunfsZhtDL6WXC3LHlqICRXgQa3E1Mvu7mGR8/35Tg==
X-Received: by 2002:a17:90a:2044:: with SMTP id n62mr43485372pjc.140.1571163133667;
        Tue, 15 Oct 2019 11:12:13 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d69sm25319342pfd.175.2019.10.15.11.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:12:13 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:12:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 05/14] software node: clean up
 property_copy_string_array()
Message-ID: <20191015181211.GD105649@dtor-ws>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-6-dmitry.torokhov@gmail.com>
 <20191015120726.GG32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120726.GG32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2019 at 03:07:26PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 04:07:12PM -0700, Dmitry Torokhov wrote:
> > Because property_copy_string_array() stores the newly allocated pointer in the
> > destination property, we have an awkward code in property_entry_copy_data()
> > where we fetch the new pointer from dst.
> 
> I don't see a problem in this function.
> 
> Rather 'awkward code' is a result of use property_set_pointer() which relies on
> data type.

No, the awkwardness is that we set the pointer once in
property_copy_string_array(), then fetch it in
property_entry_copy_data() only to set it again via
property_set_pointer(). This is confising and awkward and I believe it
is cleaner for property_copy_string_array() to give a pointer to a copy
of a string array, and then property_entry_copy_data() use it when
handling the destination structure.

Thanks.

-- 
Dmitry
