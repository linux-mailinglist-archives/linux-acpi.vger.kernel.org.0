Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12564E0FFA
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 04:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfJWCVz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Oct 2019 22:21:55 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:29063
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729994AbfJWCVz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Oct 2019 22:21:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjlFcbv7X/fZERISBqidSQtg6mzSRrpgs7U3xmSxMBsh+ECmFLmEuZ41z7Ab8XQRCjRF7mF52vqbTU3ji2Gn5g7C68McHmWI9i+HdV0XTc8W0Cc8EzR2njHRwAYXs9HP3AliU9vENwY0I/jJLNJOOv/IMu27n0GeEvSOqo7sfRJj1F+2BLxnMTABgP2AgtaUYjZrxem/nmzfcgu4GmoUPZry8lBdbaeGz1pmU8Q19SxlSLGskd0qoDXZcNLpn/r+NIoDDRhda5f1qoAQ29/3daLCex4MMYUjPqZnEFU+89GSVZjoJIAvwqBEt669ahh//Gc+oO8I87N5zymSvg5DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWFHBZWgnoIuVMJik3dR8saPth7XZXZUWJmx4b+kJL4=;
 b=Ua+P74RpRdc//x9aYboozMxfIk4n9j6eKjU70UgJkDWdtsdB/AGvRFFWMmWOvM3qcFFgSkuif3nbtqmliV7Ad1tn5XuGgVnubkwKfhsK1WeNRMp1Ro+MJC+xGvRNi+WPoogA0Codwr2cW0+tk7qxRmO6J9LA/voOnQZvbXO2ZbB1QaJnSy5qicgPhV1OiViWMiGJwoKeH38JbSg+NVGsP8EKplZQv3I824vwc6qkXJhlB4v4gml5mDlKjvX0u1BN5Fu3++vsnyOqNv1sIs1fHSe9Ts5TJuSSfq99bwqh10AP78TOnezYCRyIquYtnWzKtBXGEql0pUefV+yhZtxdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWFHBZWgnoIuVMJik3dR8saPth7XZXZUWJmx4b+kJL4=;
 b=Oq1h6gwEb2OebrwK3EYVcP2hIT0bUN40bpUv65bX16Yg2iuxqC95Cw/cHRccGuMA9Zk6uo4lIRaurGeCAWce0HT1/BEbPDQ8bL4Rb4UEFIujlI5k505aFateNmZABWVwc02VXx8HIXo/95lNKB1RgA+QER/lFik0gwDtmfT/Y98=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4640.eurprd04.prod.outlook.com (20.177.54.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.23; Wed, 23 Oct 2019 02:20:10 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58d9:b0f7:b31:c05a]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58d9:b0f7:b31:c05a%7]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 02:20:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Topic: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Index: AQHViSTjqsMfVqNAR0a2lS+zHVHmpw==
Date:   Wed, 23 Oct 2019 02:20:10 +0000
Message-ID: <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85c484b9-fa82-4010-b8b3-08d7575f87b3
x-ms-traffictypediagnostic: VI1PR04MB4640:|VI1PR04MB4640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4640461E271146F663213AECEE6B0@VI1PR04MB4640.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(305945005)(99286004)(4326008)(7696005)(102836004)(54906003)(53546011)(81166006)(74316002)(6506007)(81156014)(76176011)(256004)(26005)(6246003)(110136005)(52536014)(14444005)(5660300002)(316002)(7736002)(186003)(8936002)(7416002)(4001150100001)(25786009)(446003)(55016002)(9686003)(14454004)(486006)(66556008)(71190400001)(66066001)(64756008)(86362001)(44832011)(3846002)(6116002)(33656002)(229853002)(6436002)(76116006)(476003)(71200400001)(66946007)(91956017)(478600001)(66446008)(2906002)(66476007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4640;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5oYKiIUjDWo8hr59O3n9NbR8VGyS64skD5Bu0FLalUrkaHz6YsP53utC9dzsjsVOD5H8G1WBHyS4z9UHoY4HpBck0Kx5y8cJkFvX39lDQOXz5mVK2rNehTy5PoT55ioZWJOY94i1n2rJJGj9nQ5ZhRLaCqd1KhlGaKHzUZ+nzK3xyr7yuh29FMatWsBJolx91Z4PnKeabtEF1NSl6YAd2xA1X4sC0DHrnpENwiJHqiy/jxK2EKNMNfWv87pI6HlKyXCAskfnuW8garTM/+FB0lT2tmfAPApwSzvYbsxk8vw94+/8K8bFaHyDClaKHSFO9rb1c8O3RsE+Ms0xMHGJMdR9Qkz45Myvlh37oJ8XDz4NAoGzVutHJnXyxnsSurBSYCmYIDhNf12UJWO4DwJT7v/XZ1ju7IxtbvcVez0qNjhT8960NoQGGKYDUS8tFl0Q
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c484b9-fa82-4010-b8b3-08d7575f87b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 02:20:10.5749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0hKW8U+yKA03B+MfZuvmp8GXqT1fchvBEhzr3cL1muaX8A82nsUPWDdXWRb0wNCr0gk7Xlu+l7t8oEtfrdnNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4640
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019-10-23 1:48 AM, Rafael J. Wysocki wrote:=0A=
> On Wed, Oct 23, 2019 at 12:06 AM Leonard Crestez=0A=
> <leonard.crestez@nxp.com> wrote:=0A=
>> I've been working on a series which add DEV_PM_QOS support to devfreq,=
=0A=
>> now at v9:=0A=
>>=0A=
>> Your third patch removes DEV_PM_QOS_FREQUENCY_MIN/MAX that my series=0A=
>> depends upon. I found the email on patchwork, hopefully the in-reply-to=
=0A=
>> header is OK?=0A=
>>=0A=
>> As far as I can tell the replacement ("frequency qos") needs constraints=
=0A=
>> to be managed outside the device infrastructure and it's not obviously=
=0A=
>> usable a generic mechanism for making "min_freq/max_freq" requests to a=
=0A=
>> specific device.=0A=
> =0A=
> You can add a struct freq_constrants pointer to struct dev_pm_info and=0A=
> use it just fine.  It doesn't have to be bolted into struct=0A=
> dev_pm_qos.=0A=
=0A=
I'm not sure what you mean by this? min/max_freq was already available =0A=
in dev_pm_qos so it's not clear why it would be moved somewhere else. =0A=
What I'm looking for is a mechanism to make min/max_freq requests on a =0A=
per-device basis and DEV_PM_QOS_MIN_FREQUENCY already did that.=0A=
=0A=
Reuse is good, right?=0A=
=0A=
>> I've read a bit through your emails and it seems the problem is that=0A=
>> you're dealing with dev_pm_qos on per-policy basis but each "struct=0A=
>> cpufreq_policy" can cover multiple CPU devices.=0A=
>>=0A=
>> An alternative solution which follows dev_pm_qos would be to add=0A=
>> notifiers for each CPU inside cpufreq_online and cpufreq_offline. This=
=0A=
>> makes quite a bit of sense because each CPU is a separate "device" with=
=0A=
>> a possibly distinct list of qos requests.=0A=
> =0A=
> But combining the lists of requests for all the CPUs in a policy=0A=
> defeats the idea of automatic aggregation of requests which really is=0A=
> what PM QoS is about.=0A=
=0A=
My primary interest is the "dev" part of dev_pm_qos: making pm_qos =0A=
requests tied to a specific device.=0A=
=0A=
> There have to be two lists of requests per policy, one for the max and=0A=
> one for the min frequency >=0A=
>> If cpufreq needs a group of CPUs to run at the same frequency then it=0A=
>> should deal with this by doing dev_pm_qos_read_frequency on each CPU=0A=
>> device and picking a frequency that attempts to satisfy all constraints.=
=0A=
> =0A=
> No, that would be combining the requests by hand.=0A=
=0A=
It's just a loop though.=0A=
=0A=
>> Handling sysfs min/max_freq through dev_pm_qos would be of dubious=0A=
>> value, though I guess you could register identical requests for each CPU=
.=0A=
>>=0A=
>> I'm not familiar with what you're trying to accomplish with PM_QOS other=
=0A=
>> than replace the sysfs min_freq/max_freq files:=0A=
> =0A=
> QoS-based management of the frequency limits is not really needed for=0A=
> that.  The real motivation for adding it were things like thermal and=0A=
> platform firmware induced limits that all have their own values to=0A=
> combine with the ones provided by user space.=0A=
=0A=
Current users seem to be thermal-related. Do you care about min/max_freq =
=0A=
requests from stuff not directly tied to a CPU?=0A=
=0A=
>> What I want to do is add=0A=
>> a driver using the interconnect driver which translates requests for=0A=
>> "bandwidth-on-a-path" into "frequency-on-a-device". More specifically a=
=0A=
>> display driver could request bandwidth to RAM and this would be=0A=
>> translated into min frequency for NoC and the DDR controller, both of=0A=
>> which implement scaling via devfreq:=0A=
>>=0A=
>> This is part of an effort to upstream an out-of-tree "busfreq" feature=
=0A=
>> which allows device device to make "min frequency requests" through an=
=0A=
>> entirely out-of-tree mechanism. It would also allow finer-grained=0A=
>> scaling that what IMX tree currently support.=0A=
>>=0A=
>> If you're making cpufreq qos constrains be "per-cpufreq-policy" then=0A=
>> it's not clear how you would handle in-kernel constraints from other=0A=
>> subsystems. Would users have to get a pointer to struct cpufreq_policy=
=0A=
>> and struct freq_constraints?=0A=
> =0A=
> Yes.=0A=
> =0A=
>> That would make object lifetime a nightmare!=0A=
> =0A=
> Why really?  It is not much different from the device PM QoS case=0A=
 >> Actually,  is a simple=0A=
> one-for-one replacement of the former.  As it turns out, all of its=0A=
> users have access to a policy object anyway already.=0A=
=0A=
All current users are very closely tied to cpufreq, what I had in mind =0A=
is requests from unrelated subsystems.=0A=
=0A=
Browsing through the cpufreq core it seems that it's possible for a =0A=
struct cpufreq_policy to be created and destroyed at various points, the =
=0A=
simplest example being rmmod/modprobe on a cpufreq driver.=0A=
=0A=
The freq_qos_add_request function grabs a pointer to struct =0A=
freq_constraints, this can become invalid when cpufreq_policy is freed.=0A=
=0A=
I guess all users need to register a CPUFREQ_POLICY_NOTIFIER and make =0A=
sure to freq_qos_add_request every time? Looking at your [PATCH 2/3] I =0A=
can't spot any obvious issue, thermal clamping code seems to get the =0A=
appropriate callbacks.=0A=
>> But dev_pm_qos solves this by tying to struct device.=0A=
=0A=
The lifetime of "struct device" is already controlled by =0A=
get_device/put_device.=0A=
=0A=
> Well, the cpufreq sysfs is per-policy and not per-CPU and we really=0A=
> need a per-policy min and max frequency in cpufreq, for governors etc.=0A=
=0A=
Aggregation could be performed at two levels:=0A=
=0A=
1) Per cpu device (by dev_pm_qos)=0A=
2) Per policy (inside cpufreq)=0A=
=0A=
The per-cpu dev_pm_qos notifier would just update a per-policy =0A=
pm_qos_constraints object. The second step could even be done strictly =0A=
inside the cpufreq core using existing pm_qos, no need to invent new =0A=
frameworks.=0A=
=0A=
Maybe dev_pm_qos is not a very good fit for cpufreq because of these =0A=
"cpu device versus cpufreq_policy" issues but it makes a ton of sense =0A=
for devfreq. Can you maybe hold PATCH 3 from this series pending further =
=0A=
discussion?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
