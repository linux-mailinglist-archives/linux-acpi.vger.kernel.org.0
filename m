Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA1459FC
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFNKJV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 06:09:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44194 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfFNKJV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jun 2019 06:09:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so1766129ljc.11
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2019 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBUTP/9d4eNCeN/EaijNMsMRPRF11lY2kYs29fPMWho=;
        b=lA8ItZsv8zU0scjXM+Gj9HSHf1FNgIylWpMp1BDQ2+swnb/puvmoO0tt7yIz8Ct65B
         yryJj2b91cQeFuHbbj3J1V2y5AdJ1zqt9l7vj0KVyzVPJ0lB8JrGnKMPqY6W++L4rEaT
         utqFMYNHUZJnOxDWKajoNntqoJ89FnwFHAcOs5ZALev9OrOqSrVSTQwUw9h+ljI9J3Qc
         Tv5D1KieK5GTif5P1OCM5uI9stIbPamnYxGerNqUPzQhavSBeZ056rVim0MkRjapEgc2
         3WiM8fI/R2z2+TJEb8aN3C4sU6RnJgjnlmgTsB7omYQ79golinlsrb2sarF83rk/Jtdu
         0UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBUTP/9d4eNCeN/EaijNMsMRPRF11lY2kYs29fPMWho=;
        b=ssFgbEVk1fOiNZx0GNTxsG19nBF2f/jnQL3gz4bEsXdcGEdPXAGTLGl74SDOpWrrln
         dFEKpzcCF23fAreLXNO47c078Jy/mhTolBZYFkDQfqoy33EXPeuALd9fkz/yYLtDl4qt
         EwxvG2sVnN90slCsPVBGrdAZDAqLykAiMSzUFWoy3ZCtnCRFCFVAFJsG0/H9EP51TWFo
         SkFtMmUjljCef6S0qh1woIBP8BHfVWfWQOhAo4fI60Abh+8yOk3DJPAvfPEIGf982spc
         zR8uX3HNSthrmP+1kFst3Yd2qBXqJPReKcDtTKzcWrbR54ukUMlSD71Nyu+ryh5t4soO
         70lw==
X-Gm-Message-State: APjAAAUbV4xYfhGXq/HOs7F+AJCBhfMleHzvWxRoEy8tdCUGUlX4Baqb
        WWM6leiGyf/As9Anm0Kl6HOn7A==
X-Google-Smtp-Source: APXvYqzFjvfaIr7hZ0uqPHIOyBaOi/9LfmBYdWpPBUZqqTBN80jiQMuCXJUTUISCyY1oJPiCgUMkOg==
X-Received: by 2002:a2e:6348:: with SMTP id x69mr39647043ljb.186.1560506959356;
        Fri, 14 Jun 2019 03:09:19 -0700 (PDT)
Received: from [192.168.1.102] ([83.68.95.66])
        by smtp.googlemail.com with ESMTPSA id o11sm406073lfl.15.2019.06.14.03.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 03:09:18 -0700 (PDT)
Subject: Re: [bug report] ACPI: Add new IORT functions to support MSI domain
 handling
To:     Hanjun Guo <guohanjun@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
References: <20190613065410.GB16334@mwanda>
 <425b5d78-b38f-270b-94e2-7ece1e5498e5@arm.com>
 <5f9fecb1-66de-b550-3f8e-097795a08efe@huawei.com>
From:   Tomasz Nowicki <tn@semihalf.com>
Message-ID: <40cc7b22-d5e6-ffcf-d6ec-a74f3fbe906c@semihalf.com>
Date:   Fri, 14 Jun 2019 12:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5f9fecb1-66de-b550-3f8e-097795a08efe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 14.06.2019 03:03, Hanjun Guo wrote:
> On 2019/6/13 17:30, Robin Murphy wrote:
>> On 13/06/2019 07:54, Dan Carpenter wrote:
>>> Hello Tomasz Nowicki,
>>>
>>> The patch 4bf2efd26d76: "ACPI: Add new IORT functions to support MSI
>>> domain handling" from Sep 12, 2016, leads to the following static
>>> checker warning:
>>>
>>>      drivers/acpi/arm64/iort.c:628 iort_dev_find_its_id()
>>>      warn: array off by one? 'its->identifiers[idx]'
>>>
>>> drivers/acpi/arm64/iort.c
>>>      589  /**
>>>      590   * iort_dev_find_its_id() - Find the ITS identifier for a device
>>>      591   * @dev: The device.
>>>      592   * @req_id: Device's requester ID
>>>      593   * @idx: Index of the ITS identifier list.
>>>      594   * @its_id: ITS identifier.
>>>      595   *
>>>      596   * Returns: 0 on success, appropriate error value otherwise
>>>      597   */
>>>      598  static int iort_dev_find_its_id(struct device *dev, u32 req_id,
>>>      599                                  unsigned int idx, int *its_id)
>>>      600  {
>>>      601          struct acpi_iort_its_group *its;
>>>      602          struct acpi_iort_node *node;
>>>      603
>>>      604          node = iort_find_dev_node(dev);
>>>      605          if (!node)
>>>      606                  return -ENXIO;
>>>      607
>>>      608          node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
>>>      609          if (!node)
>>>      610                  return -ENXIO;
>>>      611
>>>      612          /* Move to ITS specific data */
>>>      613          its = (struct acpi_iort_its_group *)node->node_data;
>>>      614          if (idx > its->its_count) {
>>>                       ^^^^^^^^^^^^^^^^^^^^
>>> I wasn't able to find any information about how its->its_count is set
>>> but it looks to me that is off by one.
>>
>> its->count is read directly from the firmware table. Currently it seems this condition can never be hit anyway, since this is only ever called with idx == 0. TBH I can't really see how the code could evolve such that this check should ever be necessary (i.e. it makes no sense for callers to pull idx values out if thin air, so they'd presumably end up being derived from its->count in the first place), but if we are going to have it then I agree it should be ">=".
> 
> For now seems we only got systems which map a device to a single
> ITS, but in the IORT spec, it assumes that maybe there is a ITS group
> for mapping, so I think we can just use ">=" as you suggested to
> align with the spec.
> 

Yes, should be ">=" and the error massage should be fixed as well:

/* Move to ITS specific data */
its = (struct acpi_iort_its_group *)node->node_data;
if (idx >= its->its_count) {
         dev_err(dev, "requested ITS ID index [%d] exceeds max permitted 
[%d] index\n",
                 idx, its->its_count - 1);
         return -ENXIO;
}

Thanks,
Tomasz

