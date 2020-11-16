Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94502B4902
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgKPPUI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 10:20:08 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.115]:49416 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727820AbgKPPUI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Nov 2020 10:20:08 -0500
Received: from [100.112.133.178] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-west-2.aws.symcld.net id D7/7D-49214-0A892BF5; Mon, 16 Nov 2020 15:20:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRWlGSWpSXmKPExsWSLveKXXf+jE3
  xBn2X2Sz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWyx9ss8
  Noszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj3slAj562TUwe7/ddZfPYcrWdxePzJrkAz
  ijWzLyk/IoE1owZfbNZC67zVPy/MpG1gbGZq4uRi0NI4D+jxO/TTUwQzktGiW07ZgE5nBzCAj
  ESP/ZOZuli5OAQEUiV2NxYBlLDLHCNWWLfuVcsEA27mSTWXD3GCtLAJqAtsWXLLzYQm1fAVuJ
  Z929GEJtFQFXi+b4vYHFRgXCJ9UtWMkLUCEqcnPmEBcTmFLCTaO98zgxiMwtYSMycf54RwhaX
  uPVkPhOELS+x/e0csBoJAUWJNUuOMULYCRLLXt5hnsAoOAvJ2FlIRs1CMmoWklELGFlWMZonF
  WWmZ5TkJmbm6BoaGOgaGhrpGhob65pZ6CVW6SbplRbrlqcWl+ga6SWWF+sVV+Ym56To5aWWbG
  IExmZKQavLDsb/rz/oHWKU5GBSEuXd6bcpXogvKT+lMiOxOCO+qDQntfgQowwHh5IEb91UoJx
  gUWp6akVaZg4wTcCkJTh4lER4708DSvMWFyTmFmemQ6ROMSpKifNaTAdKCIAkMkrz4NpgqekS
  o6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHepSBTeDLzSuCmvwJazAS0eIf2BpDFJYkIKakGp
  kdvFSVfnHhbfLhu8lf5/1k3uQ/onLTb2tsdJLhN3OMHS/ju483KT5/+99Z99vnirqx+5Yq3ld
  tkvkUwH7cw2sSjm61Sf7kn5/ySNUzxHBtfuUf9VQlKOZjy4bGijdCCsvDUREXLD5WOFstfNBR
  6pm58tWjrMSuBSa8bTn2MXqThJhu37Gzh33ezQlbkNHVvnV+y4fU793dLXYua8jW1jgqYxHxd
  tSLemHMvi2/ud2Yz+w2FZX8enmXxjp92gFtwdstm/+fz/nHf3H7hj/UKe70gp/x2htwl59ZFr
  OhL3XElxUjYwEz3/Iuj/y8pXej3z+Duavx1M9I+/5WB2Ddhx1thi55PkdLsfGzM3SGjpMRSnJ
  FoqMVcVJwIAOyv8mXIAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-27.tower-356.messagelabs.com!1605539996!450!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11374 invoked from network); 16 Nov 2020 15:19:58 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-27.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Nov 2020 15:19:58 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id B9AC6E62318A45213EA6;
        Mon, 16 Nov 2020 23:19:53 +0800 (CST)
Received: from localhost.localdomain (10.38.109.160) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 16 Nov
 2020 07:19:51 -0800
Subject: Re: [External] Re: [PATCH v3] ACPI: platform-profile: Add platform
 profile support
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
References: <markpearson@lenovo.com>
 <20201115004402.342838-1-markpearson@lenovo.com>
 <qpTm5tmuwsXyXCvmpN4vhQoKis0E5jCcILd49n6_9cqzEuN_Pd9iwMEXAFRQQmGf-rCyHe-LfhjTa15-DTTu9sFQCSQaca1KVfqYggmSGts=@protonmail.com>
 <3bdd8da6-a47a-fbc6-de0e-858f493a226e@lenovo.com>
 <db12f029-cff8-2c38-7d92-38746bde96a9@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <33a0d9d8-5e37-ee5b-9c8a-ba64ad8387aa@lenovo.com>
Date:   Mon, 16 Nov 2020 10:19:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <db12f029-cff8-2c38-7d92-38746bde96a9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.109.160]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Hans

On 16/11/2020 09:33, Hans de Goede wrote:
> Hi,
> 
> On 11/16/20 12:04 AM, Mark Pearson wrote:
> 
> <snip>
>>> I believe there's no reason to remove the comma from there, and in fact,
>>> having a comma after the last entry in an array, enum, etc. seems to be
>>> the preferred.
>> OK.
>> Have to be honest - I struggle to know when comma's are needed on the last entry and when they aren't (I've had similar corrections in other cases both ways :)). I do seem to have a knack of getting it consistently wrong....
> 
> Do the rule of thumb here is, if the last element is a terminating element,
> e.g. NULL or {} or foo_number_of_foo_types in an enum foo declaration then
> there should not be a comma after the last element. The reason for is is
> that in case case new entries will be added one line above the last element.
> 
> If there is no terminating element (e.g. because ARRAY_SIZE is always used
> on the array). Then the last element should end with a comma. The reason for
> this is so that the unified diff of a patch adding a new element does not
> have -++ lines, as would be necessary when the comma is missing (-+ to add
> the comma, plus one more + for the new element).
> 
> I hope this helps explain.
It does - makes complete sense.
> 
> I expect you will send out a v4 of the entire set addressing all current
> remarks?

Absolutely. Hopefully will get that out soon but I'm going to take a bit 
longer on it as I was pretty disappointed with myself for some of the 
things that slipped into the last set. I'll aim to get a cleaner set out 
for v4.

> 
> Regards,
> 
> Hans
> 
Thanks
Mark
