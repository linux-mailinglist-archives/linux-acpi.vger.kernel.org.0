Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177282B31A6
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Nov 2020 01:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgKOAkg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Nov 2020 19:40:36 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:24258 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgKOAkf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 14 Nov 2020 19:40:35 -0500
Received: from [100.112.131.142] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id 5D/CA-03087-00970BF5; Sun, 15 Nov 2020 00:40:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRWlGSWpSXmKPExsWS8eIhry5D5YZ
  4g4VnFC32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWyx9ss8
  Noszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj3slAj562TUwe7/ddZfPYcrWdxePzJrkAz
  ijWzLyk/IoE1oyNK86xFGxlrlh54CpbA+Nlpi5GLg4hgf+MEluW3GeBcF4wSqy+uJ21i5GTQ1
  ggQeJG/3K2LkYODhEBe4kXT4JAapgFmlkkmm89gOpuZ5JYOPsNM0gDm4C2xJYtv9hAbF4BW4m
  r9/qYQGwWAVWJz09msYDYogLhEuuXrGSEqBGUODnzCdhmToEuRondT9+BNTMLWEjMnH+eEcIW
  l7j1ZD4ThC0v0bx1NjPIRRICChJ3ZhSChCWADl328g7zBEbBWUjGzkIyaRaSSbOQTFrAyLKK0
  TypKDM9oyQ3MTNH19DAQNfQ0EjX0MhS19hYL7FKN1GvtFi3PLW4RNdIL7G8WK+4Mjc5J0UvL7
  VkEyMwNlMKGhV3MF54/UHvEKMkB5OSKO9trg3xQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4P5Q
  D5QSLUtNTK9Iyc4BpAiYtwcGjJMIbDpLmLS5IzC3OTIdInWJUlBLntawASgiAJDJK8+DaYKnp
  EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3nUg43ky80rgpr8CWswEtHiHNtjikkSElFQDk
  0WUU/zCyzqHb9y68zJ3X0+8qWKEiMIV858mpw3sNn9NOSfCf0OlS+CqH5vUK1f71t3zdRosHo
  usPZt4dm7ar8XcR0LrT7PkZne5Lq6sr/hxsFyhZ0q5NF99ypeYR6Ecm/jm+S36Nn/dn2llp23
  m337JE3FqslDooumuBT0c+3Y/0cu6rypbNe3QtllSgYYmPqeNPihsfZCipHF31faOjsyP1YEf
  w6/4PrvhcmJj2fx9rzs61p8T1jGa03vY++cBle9bbdtd2HaL2IiGNH2tW5hU2XbPbO6RFStvW
  ix1v1Re4Pj9oFf4lz2PqvlUb2efWScmlmhesjjjfkLaWc+LfWKppcEKf/cdsnojvMX8qhJLcU
  aioRZzUXEiAPXwJZfIAwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-31.tower-326.messagelabs.com!1605400831!65061!1
X-Originating-IP: [104.232.225.13]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14869 invoked from network); 15 Nov 2020 00:40:32 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.13)
  by server-31.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Nov 2020 00:40:32 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id E02B71734323D5FA226D;
        Sat, 14 Nov 2020 19:40:30 -0500 (EST)
Received: from localhost.localdomain (10.38.56.206) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 14 Nov
 2020 16:40:30 -0800
Subject: Re: [External] Re: [PATCH v2 2/3] ACPI: platform-profile: Add
 platform profile support
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
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
 <20201114150102.340618-1-markpearson@lenovo.com>
 <20201114150102.340618-2-markpearson@lenovo.com>
 <CdK0cja89gyPPQ6zqxRZXa6fLNoyX_H3aMbIZtTEKQx255HoS2gKq6QESJr0f-qXlGVPXg_QFk66LHxrdgfkseCXYuk_SpfGXxx_NE-Jvbg=@protonmail.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <a565be46-5a45-2088-adaf-681344b30f88@lenovo.com>
Date:   Sat, 14 Nov 2020 19:40:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CdK0cja89gyPPQ6zqxRZXa6fLNoyX_H3aMbIZtTEKQx255HoS2gKq6QESJr0f-qXlGVPXg_QFk66LHxrdgfkseCXYuk_SpfGXxx_NE-Jvbg=@protonmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.56.206]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 14/11/2020 10:10, Barnabás Pőcze wrote:
> Hi
> 
>> [..]
>>   drivers/acpi/Kconfig            |  33 ++++++
>>   drivers/acpi/Makefile           |   1 +
>>   drivers/acpi/platform_profile.c | 181 ++++++++++++++++++++++++++++++++
>>   3 files changed, 215 insertions(+)
> 
> I believe the header file is missing from the patch.
> 
Man....that's embarrassing. Not sure how I managed to miss that :/

Updated patch coming shortly.

Mark
