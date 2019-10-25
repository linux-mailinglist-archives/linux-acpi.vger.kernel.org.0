Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE4E52F9
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfJYSEu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 14:04:50 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:64065
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731263AbfJYSEu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 14:04:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOSZYBOLmFzmBzhIh+/FQ0r24g/cD7FpolA932uvO0jsyIzxP8hDYGnPPmX3EGPXt7k5j17IAAosOEtuF7M1WsQ3PqUP9VlHxXaqVExkCMCXF5NJBR48h9YPRz2BnV+OqfFexOSROocNdKAYSw7BX4uRM+dagqAJIE0ltT/ffudHbrCzg9ijfiwG/MUywL9MFurnrs3q9O8oem1QKSUsz5ZTThngOjAHGTckogMsatRBOhpKE0mykATUwbG3Gj+gpMpOzyX+bo3Qb8rluf0QlNuekmo3DNeHvnvmyGYrBMj7eV4qb6T0j02NuU0zDKvR40DLQkBFEaIXmg42GZxsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7RFEinINwTUbUfXxeWpWsjKTGviXb7A4356E0bwvCc=;
 b=C8fDO0nQZGamZ+OzgoZhcyujnfrxDoGo42n3RjbD1EI9RMfjS2k6L48ht7+1EyIYPNXUPdSgpunhw5mh9n5YhrNz0UoYsebcE0nRNNainFOulcQ6eq56LoGyCavcSrYYFRpvJh3b++gU204WEsxZjiniKTW79n4gfqG8EOUbBtHi+ZpELJWcZj/5wRXDU38Mk+VjZpOUWTtq1v7jAKNoeBXflCjEv1j7xgZ/s6PpFNmBTpHCD/IbxN8IYh6RBhCckpFwDoXUC1nYBEi6iLqF2cBKYu7NYLASa+J5LvLiTDnPeLsB3k0jUqLqDxY4aa0kckzSoo9+dF6udInqpnOWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7RFEinINwTUbUfXxeWpWsjKTGviXb7A4356E0bwvCc=;
 b=Nfx6TLgH2ex3c2OPR3tKml2vkjLj+M6EbY3dxP3O9wj6sSIJPx/0QmPqvHy3s/aKq6OINSY/DSgFEWmGr8AYm9wehC1yEfnS6MYvLlElKTaxqE44CcR1IECgBflokftPX5tSJCpN87a4W8G16mWAr+fYT5MeCKZtFEsB2ZeOwIQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5071.eurprd04.prod.outlook.com (20.177.50.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 25 Oct 2019 18:04:44 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::24fb:fb99:b1c6:ba1f%4]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 18:04:43 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
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
Date:   Fri, 25 Oct 2019 18:04:43 +0000
Message-ID: <VI1PR04MB7023C5154E3ED29498D13C6CEE650@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0g-hTOhVJOz28CGmpcxUiiTrYyV=ARwNCN9w4doeRcCRw@mail.gmail.com>
 <VI1PR04MB7023808153A1FD2740FACF01EE6B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0gWdFVbvPobLic7F+bRrz-QUoV3GPhpawdFT0MVjAhuOQ@mail.gmail.com>
 <AM7PR04MB7015D5B0C6952BF6B04C140CEE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
 <CAJZ5v0iY4QScdQJW4xzJEMcfxkB2QDjBkR2oo3zBRL7x70PmnQ@mail.gmail.com>
 <VI1PR04MB7023C43A2E9B60A26B6DD0CCEE6A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAJZ5v0gR+hfrYf3+L5FwULuhXKxYykoWdWQphkk_OwtWqN12Uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6aea4111-e67d-44c7-1ae4-08d75975d076
x-ms-traffictypediagnostic: VI1PR04MB5071:|VI1PR04MB5071:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5071A6B6D18A13C40F90CC6CEE650@VI1PR04MB5071.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(189003)(199004)(66476007)(316002)(66446008)(66556008)(52536014)(64756008)(76116006)(91956017)(6436002)(8936002)(14454004)(81156014)(81166006)(6306002)(55016002)(8676002)(9686003)(305945005)(71190400001)(966005)(5660300002)(7696005)(66946007)(71200400001)(14444005)(256004)(33656002)(7736002)(478600001)(7416002)(6246003)(25786009)(6916009)(74316002)(486006)(4001150100001)(6116002)(4326008)(86362001)(54906003)(44832011)(476003)(446003)(53546011)(6506007)(99286004)(66066001)(229853002)(2906002)(102836004)(26005)(186003)(76176011)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5071;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qz77Xb82WwL+KwPnyaStoP4d3Mzl8MtdBVszWlXbU7WwDqdYB6DCxCef6oNMLg9RMafFUskYNKLyk0lLx8i+7q24oFPrSw84M3INpYxIUril2qozxjHQQFnr7bYoS64KQwOayKQetyBhvNNKG7796vvN4utR64ZnPd7YPitebT61a0a5FB0RTO4GGmE6WwgC8xW6a+v43GrWkQJLqoGhWy0vQyAqNNq/4Xu35tSC3TM29lwxtyZQtKL9Noqso/zfvCuYAf4N6LGmjcwl+Am5szTSwTlW/P3hUstFuh5pJlQoC2wdYJLe5WQ0O5k2XDoDoasIHCvUi2dn+pa7JbeKfTegrul4bOFYPn1tccwDO87oRrvReeWKubm0LBf5XSxWj/+ivreHGrypHp/x9l+mGWnBs6CszV2F1zlVIxzXWlT2/tSPMdcm6LPPJG5pLKb3J+mqphf71LAexuJSAW7S+LHHhCsHAdJIScla2y1lMVA=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aea4111-e67d-44c7-1ae4-08d75975d076
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 18:04:43.8655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnRPNWp5zsOPx1l9TyNBSmcYuKl5FHOGpmx4+utYHm8RukA9o3cWSIACNP1vgarXV36VXVSXvFEsSgO0C3TRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5071
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25.10.2019 00:11, Rafael J. Wysocki wrote:=0A=
> On Thu, Oct 24, 2019 at 7:47 PM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>>=0A=
>> On 24.10.2019 16:42, Rafael J. Wysocki wrote:=0A=
>>> On Wed, Oct 23, 2019 at 3:33 PM Leonard Crestez <leonard.crestez@nxp.co=
m> wrote:=0A=
>>>>=0A=
>>>> On 2019-10-23 11:54 AM, Rafael J. Wysocki wrote:=0A=
>>>>> On Wed, Oct 23, 2019 at 4:20 AM Leonard Crestez <leonard.crestez@nxp.=
com> wrote:=0A=
>>>>>> On 2019-10-23 1:48 AM, Rafael J. Wysocki wrote:=0A=
>>>=0A=
>>> [cut]=0A=
>>>=0A=
>>>>>>> But combining the lists of requests for all the CPUs in a policy=0A=
>>>>>>> defeats the idea of automatic aggregation of requests which really =
is=0A=
>>>>>>> what PM QoS is about.=0A=
>>>>>>=0A=
>>>>>> My primary interest is the "dev" part of dev_pm_qos: making pm_qos=
=0A=
>>>>>> requests tied to a specific device.=0A=
>>>>>=0A=
>>>>> The list of requests needs to be associated with the user of the=0A=
>>>>> effective constraint.  If that is the device, it is all good.=0A=
>>>>=0A=
>>>> The phrase "user of the effective constraint" is somewhat unclear.=0A=
>>>=0A=
>>> Fair enough, so let me elaborate.=0A=
>>>=0A=
>>> The effective constraint (ie. the one resulting from taking all of the=
=0A=
>>> requests in the relevant QoS list into account) affects the selection=
=0A=
>>> of an OPP, so it is natural to associate the QoS list producing it=0A=
>>> with a list of OPPs to select.  In the cpufreq case, the policy holds=
=0A=
>>> the list of OPPs and so it also should hold the corresponding QoS=0A=
>>> lists (for the min and max frequency limits).  It "uses" the effective=
=0A=
>>> constraints produced by those QoS lists by preventing the OPPs out of=
=0A=
>>> the between the min and max values  from being selected.=0A=
>>>=0A=
>>> Essentially, the policy represents a power (clock/voltage) domain with=
=0A=
>>> multiple components (it doesn't matter what they are at this level of=
=0A=
>>> abstraction). While there can be multiple sources of QoS requests=0A=
>>> associated with each component, all of these requests ultimately need=
=0A=
>>> to be passed to the domain for aggregation, because that's where the=0A=
>>> frequency selection decisions are made and so that's where the=0A=
>>> effective constraint value needs to be known. Now, the natural way to=
=0A=
>>> allow requests from multiple sources to be passed for aggregation is=0A=
>>> to provide a QoS list that they can be added to. That really is what=0A=
>>> PM QoS is for.=0A=
>>>=0A=
>>>> I'm using the target device as dev for dev_pm_qos, not the requestor.=
=0A=
>>>> This is consistent with how it was used for cpufreq: thermal called a=
=0A=
>>>> dev_pm_qos_add_request on with dev =3D cpu_dev not a thermal sensor or=
=0A=
>>>> anything else.=0A=
>>>=0A=
>>> Not really, but close. :-)=0A=
>>>=0A=
>>> Without my series (that is 5.4-rc4, say), the cpu_cooling driver adds=
=0A=
>>> its constraint to the device PM QoS of cpufreq_cdev which is a special=
=0A=
>>> device created by that driver.  That would be fine, except that the=0A=
>>> cpufreq core doesn't use that QoS.  It uses the device PM QoS of the=0A=
>>> policy->cpu device instead.  That is, that's where it adds its=0A=
>>> notifiers (see cpufreq_policy_alloc()), that's where user space=0A=
>>> requests are added (see cpufreq_online()), and (most important) that's=
=0A=
>>> where the effective constraint value is read from (see=0A=
>>> cpufreq_set_policy()).  That turns out to be problematic (in addition=
=0A=
>>> to the cpu_cooling driver's QoS requests going nowhere), because=0A=
>>> confusion ensues if the current policy->cpu goes away.=0A=
>>=0A=
>> That behavior in cpu_cooling seems like a bug.=0A=
> =0A=
> Well, kind of. :-)=0A=
> =0A=
>>>> However looking at other dev_pm_qos users there are instances of a=0A=
>>>> driver calling dev_pm_qos_add_request on it's own device but this is n=
ot=0A=
>>>> a strict requirement, correct?=0A=
>>>=0A=
>>> No, it isn't.=0A=
>>>=0A=
>>>>>>> There have to be two lists of requests per policy, one for the max =
and=0A=
>>>>>>> one for the min frequency >=0A=
>>>>>>>> If cpufreq needs a group of CPUs to run at the same frequency then=
 it=0A=
>>>>>>>> should deal with this by doing dev_pm_qos_read_frequency on each C=
PU=0A=
>>>>>>>> device and picking a frequency that attempts to satisfy all constr=
aints.=0A=
>>>>>>>=0A=
>>>>>>> No, that would be combining the requests by hand.=0A=
>>>>>>=0A=
>>>>>> It's just a loop though.=0A=
>>>>>=0A=
>>>>> Yes, it is, and needs to be run on every change of an effective=0A=
>>>>> constraint for any CPU even if the total effective constraint doesn't=
=0A=
>>>>> change.  And, of course, the per-policy user space limits would need=
=0A=
>>>>> to be combined with that by hand.=0A=
>>>>>=0A=
>>>>> Not particularly straightforward if you asked me.=0A=
>>>>=0A=
>>>> Well, this cpu-to-policy aggregation could also use a pm_qos_constrain=
t=0A=
>>>> object instead of looping.=0A=
>>>=0A=
>>> Yes, it could, but then somebody would need to add those=0A=
>>> "intermediate" requests to a proper policy-level QoS and it would need=
=0A=
>>> an extra notifier invocation to update each of them on a "component"=0A=
>>> QoS change.=0A=
>>>=0A=
>>> This is an interesting idea in case we ever need to improve the=0A=
>>> scalability of the QoS lists, but I'd rather use the simpler approach=
=0A=
>>> for now.=0A=
>>=0A=
>> The advantage I see is reducing the exposure of cpufreq internals=0A=
> =0A=
> That can be achieved by providing a helper to add a frequency QoS=0A=
> request to the min or max QoS list of the policy covering a given CPU.=0A=
> The caller of it would just need to pass the CPU number, a pointer to=0A=
> the request struct and the type.=0A=
> =0A=
> It wasn't necessary to add it at this time, though, and there would be=0A=
> the extra complication that the caller would need to know whether or=0A=
> not the policy had been created already.=0A=
=0A=
Using dev_pm_qos already provides that, and since the request is tied to =
=0A=
the struct device of the CPU there is no need to know anything about =0A=
cpufreq_policy at all.=0A=
=0A=
It would just need an additional layer of aggregation from CPU to =0A=
cpufreq_policy.=0A=
=0A=
>>>>>>> Well, the cpufreq sysfs is per-policy and not per-CPU and we really=
=0A=
>>>>>>> need a per-policy min and max frequency in cpufreq, for governors e=
tc.=0A=
>>>>>>=0A=
>>>>>> Aggregation could be performed at two levels:=0A=
>>>>>>=0A=
>>>>>> 1) Per cpu device (by dev_pm_qos)=0A=
>>>>>> 2) Per policy (inside cpufreq)=0A=
>>>>>>=0A=
>>>>>> The per-cpu dev_pm_qos notifier would just update a per-policy=0A=
>>>>>> pm_qos_constraints object. The second step could even be done strict=
ly=0A=
>>>>>> inside the cpufreq core using existing pm_qos, no need to invent new=
=0A=
>>>>>> frameworks.=0A=
>>>>>>=0A=
>>>>>> Maybe dev_pm_qos is not a very good fit for cpufreq because of these=
=0A=
>>>>>> "cpu device versus cpufreq_policy" issues but it makes a ton of sens=
e=0A=
>>>>>> for devfreq. Can you maybe hold PATCH 3 from this series pending fur=
ther=0A=
>>>>>> discussion?=0A=
>>>>>=0A=
>>>>> It can be reverted at any time if need be and in 5.4 that would be de=
ad code.=0A=
>>>>=0A=
>>>> I guess I can post v10 of my "devfreq pm qos" which starts by revertin=
g=0A=
>>>> "PATCH 3" of this series?=0A=
>>>=0A=
>>> You may do that, but I would consider adding a struct freq_constraints=
=0A=
>>> pointer directly to struct dev_pm_info and using the new frequency QoS=
=0A=
>>> helpers to manage it.=0A=
>>>=0A=
>>> Arguably, there is no need to bundle that with the rest of device PM=0A=
>>> QoS and doing the above would help to avoid some code duplication too.=
=0A=
>>=0A=
>> Adding to struct dev_pm_info would increase sizeof(struct device) while=
=0A=
>> dev_pm_qos only allocates memory when constraints are added. My=0A=
>> expectation is that very few devices would even have min_freq and=0A=
>> max_freq constraints.=0A=
> =0A=
> Well, fair enough.=0A=
> =0A=
>> Maybe struct dev_pm_qos could host a "struct freq_constraints freq"=0A=
>> instead of two separate "struct pm_qos_constraints min/max_frequency"?=
=0A=
> =0A=
> That is possible too.=0A=
> =0A=
>> This way there would be two users of freq_constraints: cpufreq_policy=0A=
>> (which is not a device) and dev_pm_qos.=0A=
>>=0A=
>> In the future freq_constraints might be extended to implement some logic=
=0A=
>> for conflicts between min_freq and max_freq requests.=0A=
> =0A=
> Sure.=0A=
=0A=
Posted for review: https://patchwork.kernel.org/cover/11212887/=0A=
